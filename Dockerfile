FROM httpd

LABEL maintainer "gokul.sureshkumar@mavenir.com"

COPY login.html /usr/local/apache2/htdocs/login.html
COPY css /usr/local/apache2/htdocs/css
