define :php_install, :enable => true do

  with_apache                                  = params[:with_apache]
  with_php_memcache                            = params[:with_php_memcache]
  with_php_apc                                 = params[:with_php_apc]
  php_packages                                 = params[:php_packages]
  pear_install_modules                         = params[:pear_install_modules]
  pear_disable_modules                         = params[:pear_disable_modules]

  # Install Base PHP
  include_recipe                                 "php"
  include_recipe                                 "php::package"
  if with_apache
    include_recipe                               "apache2::mod_php5"
  end


  # Install App Specific Packages
  if php_packages    
    php_packages.each {|p| package p}
  end

  # Install Memcache Module

  if with_php_memcache
  
    include_recipe                              "php::module_memcache"
    
    # Install Pear Package
    php_pear "memcache" do
      version                                   "2.2.6"
      action                                    :install
    end
    
    # Create Memcache.ini
    template "/etc/php.d/memcache.ini" do
      source                                    "memcache.ini.erb"
      cookbook                                  "php"
      owner                                     "root"
      group                                     "root"
      mode                                      "0644"
      variables(
        #:maxconn => node[:memcached][:maxconn], 
        #:memory => node[:memcached][:memory]
      )
      notifies :restart, resources(:service => "apache2"), :immediately
    end
      
  end

  # Install APC Module
  if with_php_apc

    include_recipe                              "php::module_apc"
    
    # Install APC Pecl
    php_pear "apc" do
      version                                   "3.1.9"
      action                                    :install
    end
    
    # Create APC.ini
    template "/etc/php.d/apc.ini" do
      source                                    "apc.ini.erb"
      cookbook                                  "php"
      owner                                     "root"
      group                                     "root"
      mode                                      "0644"
      variables(
        #:maxconn => node[:memcached][:maxconn],
        #:memory => node[:memcached][:memory]
      )
      notifies :restart, resources(:service => "apache2"), :immediately
    end
    
  end

  # Install Additional App Pecls/Pears
  if pear_install_modules
    pear_install_modules.each do |pear,ver|
      php_pear pear do
        action                                 :install
        version ver if ver && ver.length > 0
      end
    end
  end
  
  # Disables Defined Known Never Used PHP Packages
  if pear_disable_modules
    pear_disable_modules.each do |mod| 
      bash "disable_#{mod}" do
        user "root"
        Chef::Log.info "PHP moving /etc/php.d/#{mod}.ini TO /etc/php.disabled/#{mod}.ini"
        code <<-EOH
        if [ -f /etc/php.d/#{mod}.ini ]; then
          mv /etc/php.d/#{mod}.ini /etc/php.disabled/#{mod}.ini
        fi
        EOH
      end
    end
  end
  
  # Create Php.ini
  template "php.ini" do
    path                                        "/etc/php.ini"
    source                                      "php.ini.erb"
    cookbook                                    "php"
    owner                                       "root"
    group                                       "root"
    mode                                        "0644"
    variables(
      #:maxconn => node[:memcached][:maxconn],
      #:memory => node[:memcached][:memory]
    )
    notifies :restart, resources(:service => "apache2"), :immediately
  end
  
end
