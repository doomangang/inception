<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wp_db');

/** MySQL database username */
define( 'DB_USER', 'jihyjeon');

/** MySQL database password */
define( 'DB_PASSWORD', 'jihyjeon');

/** MySQL hostname */
define( 'DB_HOST', 'wp_db');

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

define( 'WP_ALLOW_REPAIR', true );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '9; &dH/gB~Lg=>[~-e=zbR%+@|PqSl hYxwXwE WxpG*3*Bb{L|QX1`SRIx|)SWF');
define('SECURE_AUTH_KEY',  'om6IVF|=osfC=mHOQqEAOyr{Y~+X{G45F/_($||OPdDgY:u?BJrC|Y@nuc|BmXc7');
define('LOGGED_IN_KEY',    '[[G)9MtH1Q~k_z5Jdo])?PI;AG7X^0s~N~`OGy3O-p{%&:(K+?irNks<+wP{-kP-');
define('NONCE_KEY',        'i|-6J)|XPZm[+8f9a0hf|Q3Ub+L592>Imh2dLQp4JG+eS1jggs5|in1yzC(Fq,kS');
define('AUTH_SALT',        '(DK$%w.t/fK86l0+-Gs|M9r7?@#, 6kU4Ecf:._X/ojo|:m% R-xh&>z!C(SW-vk');
define('SECURE_AUTH_SALT', 'v~xPoF0;||og+6xZ3ry3xts,{YX?E+E5 gl=0_?]e)(^q%hn?h-SdK1A1=+Qu0g>');
define('LOGGED_IN_SALT',   '7C|_>$79POk+J^!t[x/5$eD-`Nfi*R_PiqGM@!5QN-_U=r^]DY#IN^/h$8;-kYIl');
define('NONCE_SALT',       '[h0f?6SR)0LS:1-Pmulng,lzyL>B(u.mfN0~,3t}Z:lANV8 D&7K2[cI@qfa{-(M');
/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', true );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
?>
