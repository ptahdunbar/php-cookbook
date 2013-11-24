# Cookbook Name:: php
# Recipe:: phpenv
#
# Copyright (C) 2013 Ptah Dunbar
#
# All rights reserved - Do Not Redistribute
#

temp 		= "/tmp"
phpenv_path = node[:php][:phpenv][:path]

git "#{temp}" do
	group		node[:php][:group]
	repository 	node[:php][:phpenv][:repository]
	revision   	node[:php][:phpenv][:revision]
	action     	:checkout
end

bash "install phpenv" do
	group		node[:php][:group]

	code <<-EOF
	PHPENV_ROOT="#{phpenv_path}" . #{temp}/bin/phpenv-install.sh
	cp #{temp}/extensions/rbenv-config-add #{temp}/extensions/rbenv-config-rm "#{phpenv_path}/libexec"
	EOF

	not_if 		"test -f #{phpenv_path}/bin/phpenv"
end

directory phpenv_path do
	group  node[:php][:group]
	mode   0775
	action :create
end

directory "#{phpenv_path}/versions" do
	group  node[:php][:group]
	mode   0775
	action :create
end

cookbook_file "/etc/profile.d/phpenv.sh" do
	source 'phpenv.sh'
	group node[:php][:group]
	mode 0775
end