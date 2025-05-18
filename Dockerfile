FROM php:8.1-apache

# Cài đặt các dependencies
RUN apt-get update && apt-get install -y \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libicu-dev \
    libonig-dev \
    zip \
    unzip \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) pdo_mysql mysqli zip gd intl mbstring

# Bật mod_rewrite
RUN a2enmod rewrite

# Thiết lập thư mục làm việc
WORKDIR /var/www/html

# Copy source code EspoCRM
COPY . /var/www/html/

# Thiết lập quyền
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expose port
EXPOSE 80

# Command để chạy khi container được khởi động
CMD ["apache2-foreground"]