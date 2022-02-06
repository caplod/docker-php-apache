FROM php:8.1-apache

RUN  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get -yq --no-install-recommends install \
  # Install dependencies
  git \
  imagemagick \
  libxml2-dev \
  libfreetype6-dev \
  libicu-dev \
  libjpeg62-turbo-dev \
  libmcrypt-dev \
  libpng-dev \
  locales \
  libzip-dev \
  zlib1g-dev && \
  pecl install apcu && \
  # configure locale
  sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
  sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen && \
  dpkg-reconfigure --frontend=noninteractive locales && \
  # configure extensions
  docker-php-ext-enable apcu && \
  docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ && \
  docker-php-ext-configure intl && \
  docker-php-ext-install -j$(nproc) intl mysqli soap gd zip opcache && \
  # configure apache
  a2enmod rewrite && \
  # clean up
  apt-get clean && \
  apt-get -y purge \
  libxml2-dev \
  libicu-dev \
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libmcrypt-dev \
  libpng12-dev \
  zlib1g-dev && \
  rm -rf /var/lib/apt/lists/* /usr/src/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY config/php.ini /usr/local/etc/php/
