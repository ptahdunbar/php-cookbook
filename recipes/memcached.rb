package "memcached"
package "php5-memcached"

service "memcached" do
	supports :start => true, :stop => true, :'force-reload' => true, :status => true
	action :enable
end

execute "reset-memcached.pid-permissions" do
	command "chown nobody /var/run/memcached.pid"
end
