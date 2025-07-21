#!/bin/bash

# Esperar a que la base de datos esté disponible
echo "Esperando que la base de datos esté disponible..."
until php artisan migrate:status > /dev/null 2>&1; do
    echo "Base de datos no disponible, esperando..."
    sleep 2
done

# Ejecutar migraciones
echo "Ejecutando migraciones..."
php artisan migrate --force

# Ejecutar seeders si es necesario
if [ "$SEED_DATABASE" = "true" ]; then
    echo "Ejecutando seeders..."
    php artisan db:seed --force
fi

# Limpiar y optimizar cache
echo "Optimizando aplicación..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "Aplicación lista!"
