import csv
import os
import re
import statistics
import time
from datetime import datetime
from pathlib import Path

import requests


# ============================================================
# CONFIGURAÇÕES GERAIS
# ============================================================

DOTP_PLUS_BASE = os.getenv(
    "DOTP_PLUS_BASE",
    "http://192.168.56.102/dotproject_plus"
).rstrip("/")

DOTP_SHARP_BASE = os.getenv(
    "DOTP_SHARP_BASE",
    "http://192.168.56.101"
).rstrip("/")

USERNAME = os.getenv("DOTP_USERNAME", "admin")
PASSWORD = os.getenv("DOTP_PASSWORD", "passwd")

# Número de medições válidas por endpoint
ROUNDS = 10

# Requisições descartadas antes das medições
WARMUP_ROUNDS = 3

# Intervalo entre requisições (segundos)
REQUEST_DELAY = 0.05

# Tempo máximo de espera por requisição
REQUEST_TIMEOUT = 120

# Executar testes de IA?
RUN_AI_BENCHMARK = False

# Repetições para operações de IA.
AI_ROUNDS = 3
AI_WARMUP_ROUNDS = 1

# Diretório dos resultados
RESULTS_DIR = Path("benchmark_results")


# ============================================================
# IDENTIFICAÇÃO DO EXPERIMENTO
# ============================================================

EXPERIMENT_ID = datetime.now().strftime("%Y%m%d_%H%M%S")
EXPERIMENT_TIMESTAMP = datetime.now().isoformat(timespec="seconds")


# ============================================================
# SESSÃO / AUTENTICAÇÃO
# ============================================================

def create_session():
    session = requests.Session()
    session.headers.update({
        "User-Agent": "TCC-Benchmark/1.0",
        "Accept": "*/*"
    })
    return session


def authenticate_dotproject_plus(session):
    login_url = f"{DOTP_PLUS_BASE}/index.php"
    try:
        response = session.get(login_url, timeout=REQUEST_TIMEOUT)
        response.raise_for_status()

        login_response = session.post(
            login_url,
            data={
                "login": "login",
                "username": USERNAME,
                "password": PASSWORD,
                "redirect": ""
            },
            timeout=REQUEST_TIMEOUT,
            allow_redirects=True
        )
        login_response.raise_for_status()
        print(f"[DotProject+] Login HTTP: {login_response.status_code}")
        return True
    except requests.RequestException as error:
        print(f"[ERRO] Falha no login do DotProject+: {error}")
        return False


def extract_csrf_token(html):
    input_match = re.search(
        r'name=["\']_token["\']\s+value=["\']([^"\']+)["\']',
        html,
        re.IGNORECASE
    )
    if input_match:
        return input_match.group(1)

    meta_match = re.search(
        r'<meta\s+name=["\']csrf-token["\']\s+content=["\']([^"\']+)["\']',
        html,
        re.IGNORECASE
    )
    if meta_match:
        return meta_match.group(1)
    return None


def authenticate_dotproject_sharp(session):
    login_url = f"{DOTP_SHARP_BASE}/login"
    try:
        login_page = session.get(login_url, timeout=REQUEST_TIMEOUT)
        login_page.raise_for_status()
        login_csrf_token = extract_csrf_token(login_page.text)

        if not login_csrf_token:
            print("[ERRO] Token CSRF de login não encontrado no DotProject#.")
            return None

        login_response = session.post(
            login_url,
            data={
                "_token": login_csrf_token,
                "username": USERNAME,
                "password": PASSWORD
            },
            timeout=REQUEST_TIMEOUT,
            allow_redirects=True
        )
        login_response.raise_for_status()
        print(f"[DotProject#] Login HTTP: {login_response.status_code}")

        dashboard_url = f"{DOTP_SHARP_BASE}/dashboard"
        dashboard_response = session.get(dashboard_url, timeout=REQUEST_TIMEOUT)
        dashboard_response.raise_for_status()

        csrf_token = extract_csrf_token(dashboard_response.text)
        if not csrf_token:
            csrf_token = login_csrf_token
        return csrf_token
    except requests.RequestException as error:
        print(f"[ERRO] Falha no login do DotProject#: {error}")
        return None


# ============================================================
# MEDIÇÃO DE REQUISIÇÕES
# ============================================================

def measure_request(session, method, url, timeout=REQUEST_TIMEOUT, **kwargs):
    start_time = time.perf_counter()
    try:
        response = session.request(method=method, url=url, timeout=timeout, **kwargs)
        end_time = time.perf_counter()
        duration_ms = (end_time - start_time) * 1000.0
        response_bytes = len(response.content)
        return {
            "success": response.status_code < 400,
            "status_code": response.status_code,
            "duration_ms": duration_ms,
            "response_bytes": response_bytes,
            "error_type": "",
            "error_message": ""
        }
    except requests.exceptions.Timeout as error:
        end_time = time.perf_counter()
        duration_ms = (end_time - start_time) * 1000.0
        return {
            "success": False,
            "status_code": None,
            "duration_ms": duration_ms,
            "response_bytes": 0,
            "error_type": "Timeout",
            "error_message": str(error)
        }
    except requests.exceptions.RequestException as error:
        end_time = time.perf_counter()
        duration_ms = (end_time - start_time) * 1000.0
        return {
            "success": False,
            "status_code": None,
            "duration_ms": duration_ms,
            "response_bytes": 0,
            "error_type": type(error).__name__,
            "error_message": str(error)
        }
    except Exception as error:
        end_time = time.perf_counter()
        duration_ms = (end_time - start_time) * 1000.0
        return {
            "success": False,
            "status_code": None,
            "duration_ms": duration_ms,
            "response_bytes": 0,
            "error_type": type(error).__name__,
            "error_message": str(error)
        }


def calculate_statistics(times):
    if not times:
        return None
    average = statistics.mean(times)
    median = statistics.median(times)
    standard_deviation = statistics.stdev(times) if len(times) > 1 else 0.0
    minimum = min(times)
    maximum = max(times)
    if len(times) >= 2:
        p95 = statistics.quantiles(times, n=100, method="inclusive")[94]
    else:
        p95 = times[0]
    return {
        "valid_measurements": len(times),
        "average_ms": average,
        "median_ms": median,
        "stdev_ms": standard_deviation,
        "min_ms": minimum,
        "max_ms": maximum,
        "p95_ms": p95
    }


def format_ms(value):
    if value is None:
        return "N/A"
    if value >= 1000:
        return f"{value / 1000:.2f} s"
    return f"{value:.2f} ms"


def benchmark_endpoint(session, system_name, feature_id, feature_name, feature_type, method, url, kwargs=None, rounds=ROUNDS, warmup_rounds=WARMUP_ROUNDS, request_delay=REQUEST_DELAY):
    if kwargs is None:
        kwargs = {}
    all_measurements = []
    valid_times = []

    print(f"\n[{system_name}] ID {feature_id} - {feature_name}")
    print(f"Warm-up: {warmup_rounds} execução(ões)")
    for warmup_index in range(warmup_rounds):
        result = measure_request(session, method, url, **kwargs)
        time.sleep(request_delay)

    print(f"Medições: {rounds} execução(ões)")
    for measurement_index in range(rounds):
        result = measure_request(session, method, url, **kwargs)
        is_valid = result["success"]
        if is_valid:
            valid_times.append(result["duration_ms"])

        all_measurements.append({
            "experiment_id": EXPERIMENT_ID,
            "timestamp": EXPERIMENT_TIMESTAMP,
            "system": system_name,
            "feature_id": feature_id,
            "feature_name": feature_name,
            "feature_type": feature_type,
            "method": method,
            "url": url,
            "phase": "measurement",
            "measurement_number": measurement_index + 1,
            "valid": is_valid,
            "status_code": result["status_code"],
            "duration_ms": result["duration_ms"],
            "response_bytes": result["response_bytes"],
            "error_type": result["error_type"],
            "error_message": result["error_message"]
        })
        time.sleep(request_delay)

    stats = calculate_statistics(valid_times)
    valid_count = len(valid_times)
    failed_count = rounds - valid_count

    return {
        "experiment_id": EXPERIMENT_ID,
        "timestamp": EXPERIMENT_TIMESTAMP,
        "system": system_name,
        "feature_id": feature_id,
        "feature_name": feature_name,
        "feature_type": feature_type,
        "method": method,
        "url": url,
        "rounds_requested": rounds,
        "warmup_rounds": warmup_rounds,
        "valid_measurements": valid_count,
        "failed_measurements": failed_count,
        "average_ms": stats["average_ms"] if stats else None,
        "median_ms": stats["median_ms"] if stats else None,
        "stdev_ms": stats["stdev_ms"] if stats else None,
        "min_ms": stats["min_ms"] if stats else None,
        "max_ms": stats["max_ms"] if stats else None,
        "p95_ms": stats["p95_ms"] if stats else None,
        "all_measurements": all_measurements
    }


def build_features(csrf_token):
    sharp_ajax_headers = {
        "Accept": "application/json",
        "X-Requested-With": "XMLHttpRequest",
        "X-CSRF-TOKEN": csrf_token or ""
    }

    return [
        {"id": 1, "name": "Autenticação / Login (Página)", "type": "EQUIVALENTE", "plus": ("GET", f"{DOTP_PLUS_BASE}/index.php", {}), "sharp": ("GET", f"{DOTP_SHARP_BASE}/login", {})},
        {"id": 2, "name": "Dashboard / Visão Geral", "type": "EQUIVALENTE", "plus": ("GET", f"{DOTP_PLUS_BASE}/index.php?m=projects", {}), "sharp": ("GET", f"{DOTP_SHARP_BASE}/dashboard", {})},
        {"id": 3, "name": "Listagem de Projetos (Index)", "type": "EQUIVALENTE", "plus": ("GET", f"{DOTP_PLUS_BASE}/index.php?m=projects", {}), "sharp": ("GET", f"{DOTP_SHARP_BASE}/projects", {})},
        {"id": 4, "name": "Visualização do Projeto (Proj 2)", "type": "EQUIVALENTE", "plus": ("GET", f"{DOTP_PLUS_BASE}/index.php?m=projects&a=view&project_id=2", {}), "sharp": ("GET", f"{DOTP_SHARP_BASE}/projects/2", {})},
        {"id": 5, "name": "Estrutura Analítica / Tarefas (EAP/WBS)", "type": "EQUIVALENTE", "plus": ("GET", f"{DOTP_PLUS_BASE}/index.php?m=tasks&a=tasksperproject&project_id=2", {}), "sharp": ("GET", f"{DOTP_SHARP_BASE}/projects/2/planning/tab/activities", {})},
        {"id": 6, "name": "Cronograma e Gráfico de Gantt", "type": "EQUIVALENTE", "plus": ("GET", f"{DOTP_PLUS_BASE}/index.php?m=tasks&a=viewgantt&project_id=2", {}), "sharp": ("GET", f"{DOTP_SHARP_BASE}/projects/2/planning/tab/schedule", {})},
        {"id": 7, "name": "Gestão de Riscos (Listagem/Aba)", "type": "EQUIVALENTE", "plus": ("GET", f"{DOTP_PLUS_BASE}/index.php?m=risks", {}), "sharp": ("GET", f"{DOTP_SHARP_BASE}/projects/2/planning/tab/risks", {})},
        {"id": 8, "name": "Gestão de Empresas / Clientes (Index)", "type": "EQUIVALENTE", "plus": ("GET", f"{DOTP_PLUS_BASE}/index.php?m=companies", {}), "sharp": ("GET", f"{DOTP_SHARP_BASE}/companies", {})},
        {"id": 9, "name": "Detalhes da Empresa (com RH)", "type": "EQUIVALENTE", "plus": ("GET", f"{DOTP_PLUS_BASE}/index.php?m=companies&a=view&company_id=1", {}), "sharp": ("GET", f"{DOTP_SHARP_BASE}/companies/1", {})},
        {"id": 10, "name": "Termo de Abertura / Iniciação", "type": "ARQUITETURA_DIFERENTE", "plus": ("GET", f"{DOTP_PLUS_BASE}/index.php?m=initiating&project_id=2", {}), "sharp": ("GET", f"{DOTP_SHARP_BASE}/projects/2", {})},
        {"id": 11, "name": "Custos / Análise de Valor Agregado (EVM)", "type": "ARQUITETURA_DIFERENTE", "plus": ("GET", f"{DOTP_PLUS_BASE}/index.php?m=projects&a=view&project_id=2", {}), "sharp": ("GET", f"{DOTP_SHARP_BASE}/projects/2/planning/tab/costs", {})},
        {"id": 12, "name": "Plano de Qualidade (Tab Quality)", "type": "ARQUITETURA_DIFERENTE", "plus": ("GET", f"{DOTP_PLUS_BASE}/index.php?m=projects&a=view&project_id=2", {}), "sharp": ("GET", f"{DOTP_SHARP_BASE}/projects/2/planning/tab/quality", {})},
        {"id": 13, "name": "Assistente IA (Chat LLM Llama 3.2)", "type": "EXCLUSIVA", "plus": None, "sharp": ("POST", f"{DOTP_SHARP_BASE}/chat", {"json": {"message": "Resumo rapido", "history": [], "project_id": 2}, "headers": sharp_ajax_headers}), "ai": True},
        {"id": 14, "name": "Geração de EAP / WBS por IA", "type": "EXCLUSIVA", "plus": None, "sharp": ("POST", f"{DOTP_SHARP_BASE}/projects/2/wbs/generate-ai", {"json": {"scope": "Modulo de pagamentos"}, "headers": sharp_ajax_headers}), "ai": True, "potentially_mutating": True},
        {"id": 15, "name": "Matriz 9-Box (Desempenho x Potencial)", "type": "EXCLUSIVA", "plus": None, "sharp": ("GET", f"{DOTP_SHARP_BASE}/companies/1", {})},
        {"id": 16, "name": "Matriz RACI Interativa por Atividade", "type": "EXCLUSIVA", "plus": None, "sharp": ("GET", f"{DOTP_SHARP_BASE}/companies/1", {})},
        {"id": 17, "name": "Alocação Matricial de Recursos", "type": "PARCIAL", "plus": ("GET", f"{DOTP_PLUS_BASE}/index.php?m=human_resources", {}), "sharp": ("GET", f"{DOTP_SHARP_BASE}/companies/1", {})}
    ]


def run_benchmark():
    s_plus = create_session()
    s_sharp = create_session()

    if not authenticate_dotproject_plus(s_plus) or not (csrf_token := authenticate_dotproject_sharp(s_sharp)):
        return []

    features = build_features(csrf_token)
    summary_results = []
    raw_measurements = []

    for feature in features:
        feature_id = feature["id"]
        feature_name = feature["name"]
        feature_type = feature["type"]
        is_ai = feature.get("ai", False)

        if is_ai and not RUN_AI_BENCHMARK:
            continue

        rounds = AI_ROUNDS if is_ai else ROUNDS
        warmups = AI_WARMUP_ROUNDS if is_ai else WARMUP_ROUNDS

        if plus_spec := feature.get("plus"):
            method_p, url_p, kwargs_p = plus_spec
            res_p = benchmark_endpoint(s_plus, "DotProject+", feature_id, feature_name, feature_type, method_p, url_p, kwargs_p, rounds, warmups)
            summary_results.append(res_p)
            raw_measurements.extend(res_p["all_measurements"])

        if sharp_spec := feature.get("sharp"):
            method_s, url_s, kwargs_s = sharp_spec
            res_s = benchmark_endpoint(s_sharp, "DotProject#", feature_id, feature_name, feature_type, method_s, url_s, kwargs_s, rounds, warmups)
            summary_results.append(res_s)
            raw_measurements.extend(res_s["all_measurements"])

    return summary_results


if __name__ == "__main__":
    run_benchmark()
