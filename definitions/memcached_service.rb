define :memcached_service, :enable => true do

  include_recipe "memcached"

  # Create Memcached Sysconfig
  template "/etc/sysconfig/memcached" do
    source "memcached.sysconfig.erb"
    owner "root"
    cookbook "memcached"
    group "root"
    mode "0644"
    variables(
      :listen  => params[:memcached_listen],
      :user    => params[:memcached_user],
      :port    => params[:memcached_port],
      :maxconn => params[:memcached_maxconn],
      :memory  => params[:memcached_memory]
    )
    notifies :restart, resources(:service => "memcached"), :immediately
  end
    
end
