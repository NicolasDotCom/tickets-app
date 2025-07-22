# Usar la imagen base de PHP con Apache
FROM php:8.2-apache

# Instalar dependencias del sistema y limpiar caché en una sola capa
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    nodejs \
    npm \
    libzip-dev \
    && docker-php-ext-configure zip \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Habilitar mod_rewrite para Apache
RUN a2enmod rewrite

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Establecer el directorio de trabajo
WORKDIR /var/www/html

# Copiar archivos de configuración primero (mejor para cache de Docker)
COPY composer.json composer.lock package.json package-lock.json ./
COPY docker/apache.conf /etc/apache2/sites-available/000-default.conf

# Instalar dependencias de PHP (se cachea si no cambian los archivos composer)
RUN composer install --no-dev --optimize-autoloader --no-scripts

# Instalar dependencias de Node.js (se cachea si no cambian package files)
RUN npm ci --only=production

# Copiar el resto del código
COPY . .

# Compilar assets para producción
RUN npm run build

# Crear los directorios necesarios que Laravel necesita
RUN mkdir -p /var/www/html/bootstrap/cache \
             /var/www/html/storage/framework/sessions \
             /var/www/html/storage/framework/views \
             /var/www/html/storage/framework/cache \
             /var/www/html/storage/framework/cache/data \
             /var/www/html/storage/logs \
             /var/www/html/storage/app/public

# Ejecutar scripts post-install de Composer
RUN composer run-script post-autoload-dump

# Establecer los permisos correctos para el servidor web
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Exponer puerto 80
EXPOSE 80

# Comando por defecto
CMD ["apache2-foreground"]
