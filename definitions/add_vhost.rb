
define :add_vhost, :create => true do
  
#==================================================================
# LOAD DATA BAG
#==================================================================

  template "#{params[:name]}.vhost.conf" do
    Chef::Log.info "WEBAPP::APACHE_WWW Adding #{params[:name]}.vhost.conf for Apache"
    #cookbook "php-webapp"
    source "vhosts/#{params[:name]}.vhost.conf.erb"
    path "#{node[:apache][:dir]}/sites-available/#{params[:name]}.vhost.conf"
    owner "root"
    mode 0644
  end

  apache_site "#{params[:name]}.vhost.conf" do
    enable true
  end

#  if app['apache']['with_ssl'] ==  true
#
#    directory "#{node[:apache][:ssl_cert_dir]}" do
#      Chef::Log.info "Creating #{app[:apache][:ssl_cert_dir]} if it doesn't exist"
#      owner "root"
#      group "root"
#      mode "0755"
#      not_if "test -d #{node[:apache][:ssl_cert_dir]}"
#      action :create
#    end
  
    # Put the Key and Cert in place
#    app['apache']['ssl_cert_names'].each do |ssl_cert_name|
#      cookbook_file "#{node['apache']['ssl_cert_dir']}/#{ssl_cert_name}" do
#        Chef::Log.info "Creating #{node['apache']['ssl_cert_dir']}/#{ssl_cert_name} if it doesn't exist"
#        source "ssl/#{ssl_cert_name}"
#        owner "root"
#        mode 0600
#      end
#    end

    # Put the bundle in place
    # CA-BUNDLE
#    cookbook_file "#{node['apache']['ssl_cert_dir']}/#{app[:apache][:ssl_bundle_name]}" do
#      Chef::Log.info "Creating #{node['apache']['ssl_cert_dir']}/#{app[:apache][:ssl_bundle_name]} if it doesn't exist"
#      source "ssl/#{ssl_bundle_name}"
#      owner "root"
#      mode 0644
#    end
  
#    template "#{params[:name]}.ssl.vhost.conf" do
#      Chef::Log.info "WEBAPP::APACHE_WWW Adding #{params[:name]}.vhost.conf for Apache"
#      #cookbook "apache"
#      source "vhosts/#{params[:name]}.ssl.vhost.conf.erb"
#      path "#{node[:apache][:dir]}/sites-available/#{params[:name]}.ssl.vhost.conf"
#      owner "root"
#      mode 0644
#    end

 #   apache_site "#{params[:name]}.ssl.vhost.conf" do
 #     enable true
 #   end


#  end
  
end
