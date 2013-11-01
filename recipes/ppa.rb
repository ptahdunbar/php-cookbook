#
# Cookbook Name:: php
# Recipe:: ppa
#
# Copyright (C) 2013 Ptah Dunbar
#
# All rights reserved - Do Not Redistribute
#

if node[:php]['version'].include? '5.4'
	apt_repository "ondrej.php54" do
		uri 			'http://ppa.launchpad.net/ondrej/php5-oldstable/ubuntu'
		distribution 	node['lsb']['codename']
		components 		["main"]
		keyserver 		'keyserver.ubuntu.com'
		key				'E5267A6C'
	end
else
    apt_repository "ondrej.php55" do
		uri 			'http://ppa.launchpad.net/ondrej/php5/ubuntu'
		distribution 	node['lsb']['codename']
		components 		["main"]
		keyserver 		'keyserver.ubuntu.com'
		key				'E5267A6C'
	end
end