# Cookbook Name:: php
# Recipe:: phpbuild
#
# Copyright (C) 2013 Ptah Dunbar
#
# All rights reserved - Do Not Redistribute
#

# download php-build
git "#{node[:php]['phpbuild']['path']}" do
	repository node[:php]['phpbuild']['repository']
	reference node[:php]['phpbuild']['revision']
	action :checkout
	group	node[:php][:group]
end

# install it if it doesnt exists
bash "install php-build" do
	cwd "#{node[:php]['phpbuild']['path']}"
	code './install.sh'
	not_if "test -f php-build"
end

# create standard directories
directory "#{node[:php]['phpbuild']['path']}/versions" do
	group  node[:php][:group]
	mode   0775
	action :create
end

directory "#{node[:php]['phpbuild']['path']}/tmp" do
	group  node[:php][:group]
	mode   0775
	action :create
end

template "#{node[:php]['phpbuild']['path']}/share/php-build/default_configure_options" do
	group  node[:php][:group]
	source "default_configure_options.erb"
end

remote_directory "#{node[:php]['phpbuild']['path']}/share/php-build/definitions" do
	group       node[:php][:group]
	files_group node[:php][:group]
	files_mode  0775
	source      'definitions'
end

# install the php version
bash "installing PHP #{node[:php]['version']}" do
	code "php-build -i #{node[:php]['environment']} --pear #{node[:php]['version']} #{node[:php]['prefix_dir']}/#{node[:php]['version']}"
	not_if { File.exists?("#{node[:php]['prefix_dir']}/#{node[:php]['version']}") }
end

# Install the PHP init script
# cp php-fpm.conf.default php-fpm.conf
# create logs dir
# start PHP-FPM

