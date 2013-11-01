# Cookbook Name:: php
# Recipe:: phpenv
#
# Copyright (C) 2013 Ptah Dunbar
#
# All rights reserved - Do Not Redistribute
#

temp = "/home/#{node[:base][:user]}/tmp"
phpenv_path = "/home/#{node[:base][:user]}/.phpenv"

git "#{temp}" do
	user	node[:base][:user]
	group	node[:base][:group]
	repository node[:php][:phpenv][:repository]
	revision   node[:php][:phpenv][:revision]
	action     :checkout
end

bash "install phpenv" do
	user	node[:base][:user]
	group	node[:base][:group]

	code <<-EOF
	PHPENV_ROOT="#{phpenv_path}" . #{temp}/bin/phpenv-install.sh
	cp #{temp}/extensions/rbenv-config-add #{temp}/extensions/rbenv-config-rm "#{phpenv_path}/libexec"
	EOF

	not_if "test -f #{phpenv_path}/bin/phpenv"
end

directory phpenv_path do
	owner  node[:base][:user]
	group  node[:base][:group]
	mode   '0755'
	action :create
end

directory "#{phpenv_path}/versions" do
	owner  node[:base][:user]
	group  node[:base][:group]
	mode   '0755'
	action :create
end

cookbook_file "/etc/profile.d/phpenv.sh" do
	source 'phpenv.sh'
	owner node[:base][:user]
	group node[:base][:group]
	mode 0755
end