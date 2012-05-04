define :dir_skel, :enable => true do

  # Define Local Variables  
  app_name                      = params[:name]        # Defined in Definition Call 'app_skell "app_name" do'
  apache_dir                    = params[:apache_dir]  ? params[:apache_dir] : "/etc/httpd"
  www_root                      = params[:www_root]    ? params[:www_root]   : "/var/www"

  # App Skel Variables 
  deploy_to                     = "#{www_root}/#{app_name}"
  admin_deploy_to               = "#{www_root}/admin"
  shared_dir                    = "#{deploy_to}/shared"
  releases_dir                  = "#{deploy_to}/releases"
  vhost_include_dir             = "#{apache_dir}/sites-available/#{app_name}.vhost.d"
  
#==================================================================
# APP SKELETON - Create WebApp Directory Structure
#==================================================================

  # Create Deploy Root Directory
  directory deploy_to do
    Chef::Log.info "Creating #{deploy_to}"
    owner                      "root"
    group                      "root"
    mode                       "0755"
    action                     :create
    recursive                  true
    not_if                     "test -d #{deploy_to}"
  end 

  # Create Admin Deploy Directory
  directory admin_deploy_to do
    Chef::Log.info "Creating #{admin_deploy_to}"
    owner                      "root"
    group                      "root"
    mode                       "0755"
    action                     :create
    recursive                  true
    not_if                     "test -d #{admin_deploy_to}"
  end 

  # Create Shared Directory 
  directory shared_dir do
    Chef::Log.info "Creating #{shared_dir}"
    owner                      "root"
    group                      "root"
    mode                       "0755"
    action                     :create
    recursive                  true
    not_if                     "test -d #{shared_dir}"
  end 

  # Create Releases Directory
  directory releases_dir do
    Chef::Log.info "Creating #{releases_dir}"
    owner                      "root"
    group                      "root"
    mode                       "0755"
    action                     :create
    recursive                  true
    not_if                     "test -d #{releases_dir}"
  end 
  
  # Create App Vhost Include Directory
  directory vhost_include_dir do
    action                     :create
    mode                       0755
    owner                      "root"
    group                      "root"
    recursive                  true
    not_if                     "test -d #{vhost_include_dir}"
  end

  # TODO maybe? create and link these in to sysadmin "/sa" directory instead of /root
  link "/root/#{app_name}_approot" do
    to "#{deploy_to}"
  end  

  link "/root/#{app_name}_admin_docroot" do
    to "#{admin_deploy_to}"
  end  

  link "/root/var_log" do
    to "/var/log"
  end 
  
  link "/root/etc_dir" do
    to "/etc"
  end 

end
