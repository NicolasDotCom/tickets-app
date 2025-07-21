# Coolify Configuration
# Este archivo contiene las configuraciones necesarias para Coolify

# Variables de entorno requeridas:
# - APP_KEY: Clave de cifrado de Laravel (generar nueva para producción)
# - APP_URL: URL de tu aplicación en producción
# - DB_HOST: Host de la base de datos
# - DB_DATABASE: Nombre de la base de datos
# - DB_USERNAME: Usuario de la base de datos
# - DB_PASSWORD: Contraseña de la base de datos

# Comandos de despliegue:
# 1. composer install --no-dev --optimize-autoloader
# 2. npm install && npm run build
# 3. php artisan migrate --force
# 4. php artisan config:cache
# 5. php artisan route:cache
# 6. php artisan view:cache

# Puerto: 80 (HTTP)
# Directorio público: /public
# Comando de inicio: apache2-foreground
