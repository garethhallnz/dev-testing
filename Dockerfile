FROM communica/dev-testing


# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Add Node.js repo
RUN apt-get update \
 && apt-get install --no-install-recommends -y \
 ruby \
 ruby-dev \
 bundler \
 libfreetype6 \
 libfontconfig \
 build-essential \
 # Slim down image
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/?? /usr/share/man/??_*

RUN curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/bin
RUN composer global require drupal/coder
RUN ln -s /root/.composer/vendor/drupal/coder/coder_sniffer/Drupal /root/.composer/vendor/squizlabs/php_codesniffer/CodeSniffer/Standards/Drupal
RUN ln -s /root/.composer/vendor/drupal/coder/coder_sniffer/DrupalPractice /root/.composer/vendor/squizlabs/php_codesniffer/CodeSniffer/Standards/DrupalPractice

# Show versions
RUN node -v
RUN npm -v
RUN ruby -v
RUN bundle -v
RUN grunt --version
RUN bower --allow-root --version