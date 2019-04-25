echo 'Installing apache2'
apt-get update >/dev/null 2>&1

apt-get install apache2 -y >/dev/null 2>&1

a2enmod proxy
a2enmod proxy_http

mkdir -p /var/www/sites/projects/ts/logs
mkdir -p /var/www/sites/projects/ts/htdocs

(cat <<'EOF'
ServerName webserver

<VirtualHost *:80>
        ServerAdmin arbox@yandex.ru
        ServerName  http://projects:80

        # Indexes + Directory Root.
        DocumentRoot /var/www/sites/projects/ts/htdocs/

        # Logfiles
        ErrorLog  /var/www/sites/projects/ts/logs/error.log
        CustomLog /var/www/sites/projects/ts/logs/access.log combined

        ProxyRequests off
        ProxyPreserveHost on

        ProxyPass /ts/ http://localhost:3000/
        ProxyPassReverse /ts/ http://localhost:3000/


</VirtualHost>
EOF
) > /etc/apache2/sites-available/elearning

a2dissite 000-default
a2ensite elearning

service apache2 restart
