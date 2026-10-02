FROM php:8.4-cli-bookworm

# Evitar prompts interativos durante o apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependências de sistema e bibliotecas para extensões do PHP
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    unzip \
    zip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libicu-dev \
    default-mysql-client \
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Configurar e instalar extensões necessárias do PHP
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        pdo_mysql \
        mbstring \
        exif \
        pcntl \
        bcmath \
        gd \
        zip \
        intl \
        opcache

# Instalar Composer 2 oficial
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Instalar Node.js 22 (LTS) e npm
RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

# Definir diretório da aplicação
WORKDIR /var/www/html

# Copiar configurações personalizadas do PHP (OPcache, limites de memória)
COPY docker/app/php.ini $PHP_INI_DIR/conf.d/99-custom.ini

# Copiar script de inicialização e dar permissão de execução
COPY docker/app/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN tr -d '\r' < /usr/local/bin/entrypoint.sh > /usr/local/bin/entrypoint_unix.sh \
    && mv /usr/local/bin/entrypoint_unix.sh /usr/local/bin/entrypoint.sh \
    && chmod +x /usr/local/bin/entrypoint.sh

# Expor porta da aplicação Laravel (8080) e porta do Vite (5173)
EXPOSE 8080 5173

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
