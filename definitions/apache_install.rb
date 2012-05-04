define :apache_install, :enable => true do

  enable_apache_module            = params[:enable_apache_module]
  disable_apache_module           = params[:disable_apache_module]

  # Install Base Apache  
  include_recipe                  "apache2"
  include_recipe                  "apache2::mod_rewrite"
  include_recipe                  "apache2::mod_deflate"
  include_recipe                  "apache2::mod_headers"
  
  # If PHP   
  if params[:with_php]
      include_recipe              "apache2::mod_php5"
  end

  # If SSL
  if params[:with_ssl]
      include_recipe              "apache2::mod_ssl"
  end

  # Enables Defined Modules
  if enable_apache_module
    enable_apache_module.each do |en_mod|
      apache_module en_mod do
        enable                    true
      end
    end
  end
    
  # Disables Defined Modules
  if disable_apache_module
    disable_apache_module.each do |dis_mod|
      apache_module dis_mod do
        enable                    false
      end
    end
  end
  
  # Httpd Logrotate Using Log_Rotate CB Definition 
  include_recipe                  "logrotate"

  logrotate_app "httpd" do
    cookbook                      "logrotate"
    path                          "/var/log/httpd/*"
    frequency                     "daily"
    rotate                        15
    create                        "644 root adm"
  end
  
end
