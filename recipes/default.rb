#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright (C) 2013 Ptah Dunbar
# 
# All rights reserved - Do Not Redistribute
#

group node[:php][:group] do
	members ["root"]
	system true
	append true
	action :create
end

Chef::Log.info "[php] Install Method: #{node[:php][:install_method]}"

include_recipe "php::#{node['php']['install_method']}"
include_recipe 'php::composer'

template "/etc/php5/fpm/pool.d/www.conf.erb" do
	source "www.conf.erb"
end

Chef::Log.info "[php] XDebug enabled." if node[:php][:xdebug][:remote_enable]

directory node[:php][:xdebug][:log_dir]

template "/etc/php5/fpm/conf.d/xdebug.ini" do
	mode 0644
	source 'xdebug.ini.erb'
	cookbook if node[:php][:custom_cookbook_override]
	notifies :restart, 'service[php5-fpm]'
end
