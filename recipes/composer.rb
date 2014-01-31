# Cookbook Name:: php
# Recipe:: composer
#
# Copyright (C) 2013 Ptah Dunbar
#
# All rights reserved - Do Not Redistribute
#

remote_file "#{node['php']['composer']['install_path']}/composer" do
	source 'http://getcomposer.org/composer.phar'
	mode   '0755'
	not_if { File.exists?("#{node['php']['composer']['install_path']}/composer") }
end

node[:php][:composer][:packages].each do |pkg|
	execute "composer global require '#{pkg}'"
end
