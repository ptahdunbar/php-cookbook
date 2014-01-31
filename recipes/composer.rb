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
	execute "composer global require #{pkg}"
end

execute "update composer path" do
	command "echo 'export PATH=$PATH:~/.composer/vendor/bin' >> .bashrc"
end

file "/home/user/.bashrc" do
    owner   "root"
    #something goes here.... i don't know what. but i write
    #%{bash -i -c "source /etc/bash/bashrc && bashrc update"}

    content "JAVA_HOME=/usr/java/jdk1.1.0.05"
    content "PATH=$PATH:JAVA_HOME/bin"

  end
