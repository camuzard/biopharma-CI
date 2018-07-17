FROM lkamz/deb9-nginx
COPY webapp/index.html /var/www/html/
ADD webapp/css /var/www/html/css
ADD webapp/js /var/www/html/js
ADD webapp/fonts /var/www/html/fonts
EXPOSE 80
ENTRYPOINT service nginx start && /bin/bash