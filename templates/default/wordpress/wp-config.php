<?php
define('DB_NAME', 'wordpress');

/** MySQL database username */
define('DB_USER', 'wordpress');

/** MySQL database password */
define('DB_PASSWORD', 'wordpress');

/** MySQL hostname */
define('DB_HOST', 'db001.kitara');

define('MEM_CACHE_DEFAULT_EXPIRY',60);    // set to 1 min apr 05 10:50am ; set to 5 minutes ...
define('MEM_CACHE_EXPIRY',500);    // should be 500 or more for prod
define('MEM_CACHE_LONG_EXPIRY',1000);    // used in caching bos conifg etc

if (!defined('PIMP_KRUSTY_PLUGIN_KEY'))
{
	define('PIMP_KRUSTY_PLUGIN_KEY','pimp-krusty');
}

global $memcached_servers;
// $memcached_servers =  array('default' => array('10.0.34.23:11211','10.0.34.24:11211','10.0.34.27:11211','10.0.34.28:11211','10.0.34.29:11211','10.0.34.30:11211'));

// $memcached_servers =  array('default' => array('127.0.0.1:11211'));
