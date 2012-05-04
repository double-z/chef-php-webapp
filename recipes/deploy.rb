#
# Cookbook Name:: php-webapp
# Recipe:: deploy
#
# Author:: double_z
#

#==================================================================
# ASSIGN ROLE ATTRIBUTES TO VARS
#==================================================================
  
  # "ec2 || cloudstack || rackspace || openstack"
  cloud                                               = node['cloud_platform']           ?  node['cloud_platform']             : nil
  # "private || public"
  pub_or_priv                                         = node['pub_or_priv']              ?  node['pub_or_priv']                : nil
  # "biz_unit1 || biz_unit2 || biz_unit3"
  biz_unit                                            = node['biz_unit']                 if node['biz_unit']
  # "dev || qa || staging || prod"
  stage                                               = node['stage']                    if node['stage']
  # "local || ec2 East 1a || rackspace "
  datacenter                                          = node['datacenter']               if node['datacenter']

#==================================================================
# LOAD DATA BAG and Assign Vars 
#==================================================================

  deployment_id                                        = node['deployment_id']
  cookbook                                             = node['cookbook_name']
  app                                                  = data_bag_item('webapps', deployment_id)
  app_type                                             = app['app_type']

#==================================================================
# Apache
#==================================================================

  #
  # * Installs Minimal JEOS Apache Install - Required Modules Only *
  # * Add Modules Via Data_Bag *
  # * Apache Config Info Is In Apache2 Cookbook *
  #

  apache_install app_type do
    with_php                                         = app['php']['with_php']            ? app['php']['with_php']              : nil
    with_ssl                                         = app['apache']['with_ssl']         ? app['apache']['with_ssl']           : nil
    enable_apache_module                             = app['apache']['enable_module']    ? app['apache']['enable_module']      : nil
    disable_apache_module                            = app['apache']['disable_module']   ? app['apache']['disable_module']     : nil
  end

#==================================================================
# Memcached
#==================================================================

  #
  # * Installs, Configures, Enables and Starts Memcached *
  # * only if memcached is defined as included *
  #

  with_memcached                                    = app['memcached']['with_memcached'] ? app['memcached']['with_memcached']  : false

  if with_memcached

    memcached_service app_type do
      memcached_memory                              = app['memcached']['memory']         # * This is Required *
      memcached_port                                = app['memcached']['port']           # * This is Required *
      memcached_user                                = app['memcached']['user']           # * This is Required *
      memcached_maxconn                             = app['memcached']['maxconn']        # * This is Required *
      memcached_listen                              = app['memcached']['listen']         ? app['memcached']['listen']          : nil
    end

  end

#==================================================================
# PHP
#==================================================================

  #
  # * Installs Minimal JEOS PHP - Required Modules Only *
  # * Add Modules Via Data_Bag *
  # * Base PHP Config Info Is In PHP Cookbook *
  #

  php_install app_type do
    with_apache                                     = app['apache']['with_apache']        ? app['apache']['with_apache']       : false
    with_php_memcache                               = app['php']['with_memcache']         ? app['php']['with_memcache']        : false
    with_php_apc                                    = app['php']['with_apc']              ? app['php']['with_apc']             : false
    php_packages                                    = app['php']['packages']              ? app['php']['packages']             : nil
    pear_install_modules                            = app['php']['install_modules']       ? app['php']['install_modules']      : nil
    pear_disable_modules                            = app['php']['disable_modules']       ? app['php']['disable_modules']      : nil
  end
  
#==================================================================
# Roll Through Data Bag Defined Apps 
#==================================================================

app['vhosts'].each do |server_name|

  #==================================================================
  # APP SKELETON TODO 
  #==================================================================

  #
  # * Creates Base Vhost Dir Structure *
  # * Not If Base Dir Structure Already Exist *
  # * Creates Vhost Include.d Directory For Each server_name *
  #

  dir_skel server_name do
    apache_dir                                      = node[:apache][:dir]
    deploy_root                                     = app['#{server_name}']['deploy_root']
  end

  #==================================================================
  # Vhosts
  #==================================================================  

  #
  # * Creates And Populates Virtual Host *
  #

  add_vhost server_name do
      :create
  end

#==================================================================
# End Roll Through Data Bag Defined Apps 
#==================================================================

end
 
#==================================================================
# Include Additional Recipes to Complete Build
#==================================================================

#  if ['devqa'].include? node[:instance_role]
#    include_recipe "#{cookbook}::devqa"
#  end

#  include_recipe "#{cookbook}::mail"
   
#  include_recipe "#{cookbook}::cronjobs"
  
#  include_recipe "#{cookbook}::logging"
  
#  include_recipe "#{cookbook}::monitoring"

#  include_recipe "#{cookbook}::convenience_links"
  
#  include_recipe "#{cookbook}::finalize_and_annontate"
  
#  include_recipe "#{cookbook}::clean_runlist"

