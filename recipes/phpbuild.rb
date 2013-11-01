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
	user	node[:base][:user]
	group	node[:base][:group]
end

# install it if it doesnt exists
bash "install php-build" do
	cwd "#{node[:php]['phpbuild']['path']}"
	code './install.sh'
	not_if "test -f php-build"
end

# create standard directories
directory "#{node[:php]['phpbuild']['path']}/versions" do
	owner  node[:base][:user]
	group  node[:base][:group]
	mode   '0755'
	action :create
end

directory "#{node[:php]['phpbuild']['path']}/tmp" do
	owner  node[:base][:user]
	group  node[:base][:group]
	mode   '0755'
	action :create
end

template "#{node[:php]['phpbuild']['path']}/share/php-build/default_configure_options" do
	owner  node[:base][:user]
	group  node[:base][:group]
	source "default_configure_options.erb"
end

remote_directory "#{node[:php]['phpbuild']['path']}/share/php-build/definitions" do
	owner       node[:base][:user]
	group       node[:base][:group]
	files_owner node[:base][:user]
	files_group node[:base][:group]
	files_mode  '0755'
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