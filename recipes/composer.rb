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

bash "globally install composer packages" do
  code <<-EOH
      composer global require phing/phing:2.6.*
      composer global require phpunit:phpunit/3.7.*
      composer global require wp-cli/wp-cli:0.13
  EOH
end
