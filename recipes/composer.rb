# Cookbook Name:: php
# Recipe:: composer
#
# Copyright (C) 2013 Ptah Dunbar
#
# All rights reserved - Do Not Redistribute
#

include_recipe "composer"

composer_package "Install PHP tools for development" do
    action [:create, :update]
    user node[:composer][:user]
    group node[:composer][:group]
    install_path node[:composer][:target_dir]
    packages (node[:php][:composer][:packages])
    config ({"bin-dir" => "/usr/local/bin"})
end