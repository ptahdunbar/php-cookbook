#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright (C) 2013 Ptah Dunbar
# 
# All rights reserved - Do Not Redistribute
#

include_recipe "php::#{node['php']['install_method']}"
include_recipe 'php::composer'

template "/etc/php5/fpm/pool.d/www.conf.erb" do
	source "www.conf.erb"
end