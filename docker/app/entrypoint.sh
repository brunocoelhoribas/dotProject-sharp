#!/bin/bash
set -e

echo "=========================================================="
echo "Iniciando ambiente dotProject# via Docker..."
echo "=========================================================="

# 1. Configurar o arquivo .env se nao existir
if [ ! -f /var/www/html/.env ]; then
    echo "Arquivo .env nao encontrado. Copiando de .env.example..."
    cp /var/www/html/.env.example /var/www/html/.env
fi

# 2. Instalar dependencias do Composer se o diretorio vendor nao existir
if [ ! -d /var/www/html/vendor ]; then
    echo "Instalando dependencias do Composer (vendor)..."
    composer install --no-interaction --prefer-dist --optimize-autoloader
else
    echo "Diretorio vendor ja existente."
fi

# 3. Gerar APP_KEY caso nao esteja definida
if ! grep -q "^APP_KEY=base64:" /var/www/html/.env; then
    echo "Gerando APP_KEY para a aplicacao..."
    php artisan key:generate --force
fi

# 4. Aguardar o banco de dados MySQL estar pronto para conexoes
DB_HOST=${DB_HOST:-mysql}
DB_PORT=${DB_PORT:-3306}
DB_DATABASE=${DB_DATABASE:-dotproject}
DB_PASSWORD=${DB_PASSWORD:-12345}

echo "Aguardando banco de dados MySQL em ${DB_HOST}:${DB_PORT}..."
until php -r "
try {
    new PDO('mysql:host=' . (getenv('DB_HOST') ?: 'mysql') . ';port=' . (getenv('DB_PORT') ?: '3306') . ';dbname=' . (getenv('DB_DATABASE') ?: 'dotproject'), 'root', (getenv('DB_PASSWORD') ?: '12345'));
    exit(0);
} catch (Throwable \$t) {
    exit(1);
}
"; do
    echo "   ... Aguardando inicializacao do MySQL..."
    sleep 2
done
echo "Conexao com o banco de dados MySQL estabelecida!"

# 5. Executar migracoes pendentes
echo "Verificando e executando migracoes do banco de dados..."
php artisan migrate --force

# 6. Instalar dependencias npm e compilar assets se necessario
if [ ! -d /var/www/html/node_modules ]; then
    echo "Instalando dependencias do Front-end (Node.js/npm)..."
    npm install --no-audit --prefer-offline || npm install
fi

if [ ! -d /var/www/html/public/build ]; then
    echo "Compilando assets do front-end com Vite..."
    npm run build
fi

# 7. Limpar caches para garantir estado limpo
echo "Limpando caches de configuracao e rotas..."
php artisan config:clear
php artisan route:clear
php artisan view:clear

echo "=========================================================="
echo "dotProject# pronto! Acesse em: http://localhost:8080"
echo "=========================================================="

# 8. Iniciar o servidor HTTP do Laravel com suporte a múltiplos workers
exec php artisan serve --host=0.0.0.0 --port=8080 --no-reload