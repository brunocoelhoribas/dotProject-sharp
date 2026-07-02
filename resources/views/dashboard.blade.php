@extends('layouts.app')

@section('content')
    <div class="d-flex flex-column min-vh-100">

        <header>
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm py-3">
                <div class="container">
                    <a class="navbar-brand fw-bold text-warning d-flex align-items-center gap-2" href="{{ route('dashboard') }}">
                        <i class="bi bi-rocket-takeoff-fill text-warning"></i>
                        <span>dotProject#</span>
                    </a>

                    <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#main-nav" aria-controls="main-nav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="main-nav">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0 fw-medium">
                            <li class="nav-item">
                                <a class="nav-link px-3" href="{{ route('companies.index') }}">
                                    <i class="bi bi-building me-1"></i> {{ __('layout.nav.companies') }}
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link px-3" href="{{ route('projects.index') }}">
                                    <i class="bi bi-folder-fill me-1"></i> {{ __('layout.nav.projects') }}
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link px-3" href="{{ route('costs.index') }}">
                                    <i class="bi bi-cash-stack me-1"></i> {{ __('layout.nav.costs') }}
                                </a>
                            </li>
                        </ul>

                        <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-center fw-medium">
                            <li class="nav-item dropdown me-3">
                                <a class="nav-link dropdown-toggle d-flex align-items-center gap-1" href="#" role="button" data-bs-toggle="dropdown">
                                    <i class="bi bi-globe"></i>
                                    <span>{{ strtoupper(app()->getLocale()) === 'PT_BR' ? 'PT' : strtoupper(app()->getLocale()) }}</span>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 rounded-3">
                                    <li>
                                        <a class="dropdown-item d-flex justify-content-between align-items-center py-2" href="{{ route('lang.switch', 'pt_BR') }}">
                                            <span>Português</span> <span class="fs-5">🇧🇷</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item d-flex justify-content-between align-items-center py-2" href="{{ route('lang.switch', 'en') }}">
                                            <span>English</span> <span class="fs-5">🇺🇸</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item d-flex justify-content-between align-items-center py-2" href="{{ route('lang.switch', 'es') }}">
                                            <span>Español</span> <span class="fs-5">🇪🇸</span>
                                        </a>
                                    </li>
                                </ul>
                            </li>

                            <li class="nav-item dropdown border-start ps-3 border-secondary">
                                <a class="nav-link dropdown-toggle d-flex align-items-center gap-2" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                                    <i class="bi bi-person-circle fs-5"></i>
                                    <span>Admin, Sempre</span>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 rounded-3">
                                    <li>
                                        <a class="dropdown-item py-2" href="#">
                                            <i class="bi bi-person me-2"></i> {{ __('layout.nav.my_data') }}
                                        </a>
                                    </li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li>
                                        <form method="POST" action="{{ route('logout') }}" class="m-0">
                                            @csrf
                                            <button type="submit" class="dropdown-item text-danger py-2">
                                                <i class="bi bi-box-arrow-right me-2"></i> {{ __('layout.nav.logout') }}
                                            </button>
                                        </form>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>

        <main class="flex-grow-1 container py-4 py-md-5">
            @yield('dashboard-content')
        </main>

        {{-- Modal de status global (showMessage disponível em todas as páginas) --}}
        @includeIf('components.status_modal')

        <footer class="text-center py-4 text-muted small border-top bg-white mt-auto">
            <div class="container">
                <p class="mb-1 fw-medium text-dark">dotProject+ | Uma Ferramenta Educacional para o Gerenciamento de Projetos</p>
                <a href="http://www.gqs.ufsc.br/evolution-of-dotproject/"
                    class="text-decoration-none text-primary fw-semibold"
                    target="_blank">www.gqs.ufsc.br/evolution-of-dotproject</a>
            </div>
        </footer>

    </div>
@endsection
