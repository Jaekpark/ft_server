# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    run.sh                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: parkjaekwang <marvin@42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/01 17:02:09 by parkjaekw         #+#    #+#              #
#    Updated: 2021/03/03 21:31:30 by jaekpark         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# authority
chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*

# ssl key-gen
openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=KR/L=Seoul/O=InnovatianAcademy/OU=42Seoul/CN=localhost" -keyout /etc/ssl/private/ft_server.key -out /etc/ssl/certs/ft_server.crt
chmod 600 etc/ssl/certs/ft_server.crt etc/ssl/private/ft_server.key

# move nginx default file
mv ./tmp/default etc/nginx/sites-available/default

# install wordpress
wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
mv wordpress/ var/www/html/wordpress
chown -R www-data:www-data /var/www/html/wordpress
rm -rf latest.tar.gz

# config wordpress
mv ./tmp/wp-config.php var/www/html/wordpress/wp-config.php

# config sql
service mysql start
echo "CREATE DATABASE IF NOT EXISTS wordpress;" | mysql -u root --skip-password
echo "CREATE USER IF NOT EXISTS 'jaekpark'@'localhost' IDENTIFIED BY 'jaekpark';" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'jaekpark'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password

# install phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz
tar -xvf phpMyAdmin-5.0.2-all-languages.tar.gz
mv phpMyAdmin-5.0.2-all-languages /var/www/html/phpmyadmin
rm -rf phpMyAdmin-5.0.2-all-languages.tar.gz

# config phpmyadmin
mv ./tmp/config.inc.php var/www/html/phpmyadmin/config.inc.php

# start service
service nginx start
service php7.3-fpm start
service mysql restart

bash
