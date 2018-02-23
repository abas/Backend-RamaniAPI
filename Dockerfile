FROM ubuntu:14.04

MAINTAINER alfin hidayat <kahid.na@gmail.com>

ENV CONNECTION=
ENV HOST=
ENV PORT=
ENV DATABASE=
ENV USERNAME=
ENV PASSWORD=

RUN apt-get update && apt-get install software-properties-common wget curl wget nano unzip -y

RUN sudo apt-get install -y language-pack-en-base

RUN sudo LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php; apt-get update 

RUN apt-get install php7.1 -y apache2 php7.1-mbstring curl php5-cli git mysql-client

RUN curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

COPY . /var/www/html

RUN cp /var/www/html/.env.example /var/www/html/.env

RUN sed "s/DB_CONNECTION=/DB_CONNECTION=$DB_CONNECTION/g" --in-place /var/www/html/.env; \
	sed "s/DB_HOST=/DB_HOST=$DB_HOST/g" --in-place /var/www/html/.env; \
	sed "s/DB_PORT=/DB_PORT=$DB_PORT/g" --in-place /var/www/html/.env; \
	sed "s/DB_DATABASE=/DB_DATABASE=$DATABASE/g" --in-place /var/www/html/.env; \
	sed "s/DB_USERNAME=/DB_USERNAME=$USERNAME/g" --in-place /var/www/html/.env; \
	sed "s/DB_PASSWORD=/DB_PASSWORD=$PASSWORD/g" --in-place /var/www/html/.env;

RUN chmod +x /var/www/html/entrypoint.sh

EXPOSE 80 443

CMD ["/var/www/html/entrypoint.sh"]
