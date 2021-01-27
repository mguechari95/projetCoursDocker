FROM php:7.4-fpm-alpine

# Apk install
RUN apk --no-cache update && apk --no-cache add bash git

#install pdo
RUN docker-php-ext-install pdo_mysql

#config git in the container
RUN git config --global user.email "moussa@mail.com" && git config --global user.name "guechari"


# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php && php -r "unlink('composer-setup.php');" && mv composer.phar /usr/local/bin/composer



# Symfony CLI
RUN wget https://get.symfony.com/cli/installer -O - | bash && mv /root/.symfony/bin/symfony /usr/local/bin/symfony

#Create new project
RUN symfony new my_syn_app_mg --full
RUN symfony server:ca:install
#move to project directory 
RUN cd my_syn_app_mg
#Start server 
RUN symfony server:start -d


WORKDIR /var/www/html
