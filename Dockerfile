FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN apt-get install -y \
 curl \
 build-essential \
 python

# Install php
RUN apt-get install -y php php-cli php-xml

# Install phpcs
RUN curl https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar -L -o /tmp/phpcs.phar \
  && chmod a+x /tmp/phpcs.phar \
  && mv /tmp/phpcs.phar /usr/bin/phpcs

# Install node
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get install -y nodejs

# Install ruby
RUN apt-get install -y \
  ruby \
  ruby-dev \
  bundler

# Slim down image
RUN apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/?? /usr/share/man/??_*

RUN curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/bin
RUN composer global require drupal/coder
RUN phpcs --config-set installed_paths /root/.composer/vendor/drupal/coder/coder_sniffer

# Show versions
RUN php -v
RUN node -v
RUN npm -v
RUN ruby -v
RUN bundle -v
RUN phpcs -i
