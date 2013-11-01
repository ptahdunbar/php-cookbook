# Cookbook Name:: php
# Recipe:: source
#
# Copyright (C) 2013 Ptah Dunbar
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'build-essential'
include_recipe 'xml'
include_recipe 'git'
include_recipe 'base'

node['php']['dependencies'].each do |pkg|
	package pkg do
		action :install
	end
end

case node[:platform]
when "ubuntu", "debian"
  link "/usr/lib/libpng.so" do
    to "/usr/lib/#{node[:php]['arch']}-linux-gnu/libpng.so"
  end

  link "/usr/lib/libkrb5.so" do
    to "/usr/lib/#{node[:php]['arch']}-linux-gnu/libkrb5.so"
  end

  if node[:platform_version].to_f >= 12.04
    link "/usr/lib/libmysqlclient_r.so" do
      to "/usr/lib/#{node[:php]['arch']}-linux-gnu/libmysqlclient_r.so"
    end
  end

  if node[:platform_version].to_f >= 11.10
    package "libltdl-dev" do
      action :install
    end

    # on 11.10+, we also have to symlink libjpeg and a bunch of other libraries
    # because of the 32-bit/64-bit library directory separation. MK.
    link "/usr/lib/libjpeg.so" do
      to "/usr/lib/#{node[:php]['arch']}-linux-gnu/libjpeg.so"
    end

    link "/usr/lib/libstdc++.so.6" do
      to "/usr/lib/#{node[:php]['arch']}-linux-gnu//usr/lib/libstdc++.so.6"
    end
  end
end

include_recipe 'php::phpenv'
include_recipe 'php::phpbuild'

execute "using PHP #{node[:php][:version]}" do
	command "/home/#{node[:base][:user]}/.phpenv/bin/phpenv global #{node[:php][:version]}"
end