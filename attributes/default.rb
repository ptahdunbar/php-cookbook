default[:php][:install_method]				= 'package'
default[:php][:version] 					= '5.4.21'
default[:php][:versions] 					= %w(5.5.6 5.4.22 5.3.27)
default[:php][:environment] 				= node[:chef_environment] ? node[:chef_environment] : 'production'
default[:php][:group] 						= 'admin'
default[:php][:arch]						= (kernel[:machine] =~ /x86_64/ ? "x86_64" : "i386")

default[:php][:fpm_user]      				= node[:nginx][:user] if node[:apache][:user]
default[:php][:fpm_group]     				= node[:nginx][:group] if node[:apache][:group]
default[:php][:fpm_user]      				= node[:nginx][:user] if node[:nginx][:user]
default[:php][:fpm_group]     				= node[:nginx][:group] if node[:nginx][:group]

default[:php][:variables_order] = 'EGPCS'

#{node['php']['fpm_group']}
default[:php][:pm][:max_children] = 30
default[:php][:pm][:start_servers] = 2
default[:php][:pm][:min_spare_servers] = 2
default[:php][:pm][:max_spare_servers] = 5
default[:php][:pm][:process_idle_timeout] = '10s'
default[:php][:pm][:max_requests] = 50

default[:php][:log_dir] = '/var/log/php-fpm'
default[:php][:enable_slowlog] = false;
default[:php][:slowlog_path] = "#{node[:php][:log_dir]}/slow.log"
default[:php][:request_slowlog_timeout] = '10s'


default[:php][:dependencies]  				= %w(libcurl4-openssl-dev libpq-dev libreadline-dev openssl libssl-dev libxslt1-dev zlib1g-dev libbz2-dev libc-client2007e-dev libkrb5-dev libcurl4-gnutls-dev libfreetype6-dev libgmp3-dev libjpeg8-dev libmcrypt-dev libpng12-dev libt1-dev libmhash-dev libexpat1-dev libicu-dev libtidy-dev re2c lemon)
default[:php][:packages] 					= %w(php5-fpm php5-cli php5-common php5-dev php5-imagick php5-xdebug php5-mcrypt php5-mysql php5-imap php5-curl php-pear php5-gd php-apc)

default[:php][:composer][:install_path] 	= '/usr/local/bin'
default[:php][:composer][:packages] 	    = {"phpunit/phpunit" => "3.7.*", "phing/phing" => "2.4.*", "wp-cli/wp-cli" => "0.13"}
default[:php][:composer][:user] 	        = 'vagrant'

default[:php][:phpbuild][:install_path] 	= "/usr/share/php-build"
default[:php][:phpbuild][:repository] 	    = "git://github.com/CHH/php-build.git"
default[:php][:phpbuild][:revision] 		= "99be44e6c45ee5edd147cea237cba3e4f1480f6c"

default[:php][:phpenv][:path] 			    = "/usr/share/phpenv"
default[:php][:phpenv][:repository] 		= 'git://github.com/CHH/phpenv.git'
default[:php][:phpenv][:revision] 		    = '3cd7ab3ef679b05c3af80e1ff92ec75fca3f9c6b'


default[:php][:prefix_dir] 						= "#{node[:php][:phpenv][:path]}/versions"

default[:php][:xdebug][:remote_enable] 			    = false
default[:php][:xdebug][:remote_host] 				= ""
default[:php][:xdebug][:remote_port] 				= 9000
default[:php][:xdebug][:collect_includes] 			= true
default[:php][:xdebug][:collect_params] 			= true
default[:php][:xdebug][:dump_globals] 				= true
default[:php][:xdebug][:var_display_max_children] 	= -1
default[:php][:xdebug][:var_display_max_data] 		= -1
default[:php][:xdebug][:var_display_max_depth] 	    = -1
default[:php][:xdebug][:log_dir] 					= "#{default[:php][:log_dir]}/xdebug"

default[:php][:xdebug][:profiler_enable] 			= false
default[:php][:xdebug][:profiler_enable_trigger] 	= false
default[:php][:xdebug][:profiler_output_dir] 		= "#{default[:php][:log_dir]}/profiler"
default[:php][:xdebug][:profiler_output_name] 		= "cachegrind.out.%t-%s"
