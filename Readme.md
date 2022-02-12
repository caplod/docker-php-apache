Docker image with Apache and PHP with composer (preconfigured with imagemagick,
apcu, intl, mysqli, soap, gd, zip and opcache) and nullmailer

Older PHP versions are available at https://github.com/caplod/docker-php-apache/branches
    
## usage

Use the prebuild from docker hub

`docker run --rm -v $(pwd):/var/www/html/ -p 8080:80
tan3/php-apache:latest`

Or in your `docker-compose.yaml` you can use this image as

    services:
      app:
        image: tan3/php-apache:latest

Then start with 

    docker-compose up

## customize

To create your custom image based on this repository follow these steps:

    git clone https://github.com/caplod/docker-php-apache
    cd docker-php-apache
    sudo service docker start
    sudo docker build . -t custom-php-apache:8.1
