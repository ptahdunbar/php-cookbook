#
# Cookbook Name:: php
# Recipe:: package
#
# Copyright (C) 2013 Ptah Dunbar
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'php::ppa'

node[:php]['packages'].each do |pkg|
	package pkg
end

if node[:php]['version'].include? '5.5'
	php_ini_file = "php.ini-5.5-#{node['php']['environment']}.erb"
elsif node[:php]['version'].include? '5.4'
	php_ini_file = "php.ini-5.4-#{node['php']['environment']}.erb"
elsif node[:php]['version'].include? '5.3'
	php_ini_file = "php.ini-5.3-#{node['php']['environment']}.erb"
end

Chef::Log.info "[php] Version: #{node[:php][:version]}"
Chef::Log.info "[php] INI: #{php_ini_file}"

template "/etc/php5/fpm/php.ini" do
	source php_ini_file
	mode 0440
	owner "root"
	group "root"
	cookbook if node[:php][:custom_cookbook_override]
end

service 'php5-fpm' do
	service_name 'php5-fpm'
	restart_command 'service php5-fpm restart && sleep 1'
	reload_command 'service php5-fpm reload && sleep 1'
	status_command 'service php5-fpm status'
	supports [:restart, :reload, :status]
	action [ :enable, :start ]
end