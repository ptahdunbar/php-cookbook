default['php']['install_method']	= 'package'
default['php']['version'] 			  = '5.4.21'
default['php']['versions'] 			  = %w(5.5.5 5.4.21 5.2.4)
default['php']['environment'] 		= 'development'
default['php']['arch']				    = (kernel['machine'] =~ /x86_64/ ? "x86_64" : "i386")

default['php']['fpm_user']      	= 'www-data'
default['php']['fpm_group']     	= 'www-data'
default['php']['dependencies']  	= %w(libcurl4-openssl-dev libpq-dev libreadline-dev openssl libssl-dev libxslt1-dev zlib1g-dev libbz2-dev libc-client2007e-dev libkrb5-dev libcurl4-gnutls-dev libfreetype6-dev libgmp3-dev libjpeg8-dev libmcrypt-dev libpng12-dev libt1-dev libmhash-dev libexpat1-dev libicu-dev libtidy-dev re2c lemon)
default['php']['prefix_dir'] 	    = "/home/vagrant/.phpenv/versions"
default['php']['packages'] 	      = %w(php5-fpm php5-cli php5-common php5-dev memcached php5-memcached php5-imagick php5-xdebug php5-mcrypt php5-mysql php5-imap php5-curl php-pear php5-gd php-apc)

include_attribute 'php::composer'
include_attribute 'php::phpbuild'
include_attribute 'php::phpenv'
