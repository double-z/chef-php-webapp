<?php

/** Sample Configuration 1: Using the Default Server **/
/** NOTE: THIS IS ACTIVE BY DEFAULT. COMMENT IT OUT. **/

/**
 * This is the most basic way to add a server to HyperDB using only the
 * required parameters: host, user, password, name.
 * This adds the DB defined in wp-config.php as a read/write server for
 * the 'global' dataset. (Every table is in 'global' by default.)
 */
$wpdb->add_database(array(
        'host'     => DB_HOST,     // If port is other than 3306, use host:port.
        'user'     => DB_USER,
        'password' => DB_PASSWORD,
        'name'     => DB_NAME,
        'write'    => 1,
        'read'     => 1,
));




$wpdb->add_database(array(
        'host'     => 'db002.kitara',     // If port is other than 3306, use host:port.
        'user'     => DB_USER,
        'password' => DB_PASSWORD,
        'name'     => DB_NAME,
        'write'    => 0,
        'read'     => 1,
));

