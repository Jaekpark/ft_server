# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jaekpark <jaekpark@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/01 17:02:22 by parkjaekw         #+#    #+#              #
#    Updated: 2021/03/18 22:03:20 by jaekpark         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	debian:buster

# update & upgrade
RUN	apt-get update && apt-get -y upgrade

# Install nginx
RUN apt-get -y install nginx

# Install php
RUN apt-get -y install php7.3-fpm php-mysql php-mbstring

# Install mysql
RUN apt-get -y install mariadb-server

# Install openssl
RUN apt-get -y install openssl

# Install utils
RUN apt-get -y install curl wget vim

# Copy source files
COPY ./srcs/run.sh ./tmp/run.sh
COPY ./srcs/default ./tmp/default
COPY ./srcs/wp-config.php ./tmp/wp-config.php
COPY ./srcs/config.inc.php ./tmp/config.inc.php

CMD bash ./tmp/run.sh

EXPOSE 80 443
