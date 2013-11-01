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