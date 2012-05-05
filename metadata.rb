maintainer       "YOUR_COMPANY_NAME"
maintainer_email "YOUR_EMAIL"
license          "All rights reserved"
description      "Installs/Configures template-app"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.2"

depends "apache2"
depends "php"
depends "logrotate"
depends "memcached"
