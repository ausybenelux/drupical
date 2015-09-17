default["php5"]["keyserver"] = 'keyserver.ubuntu.com'

# key of providers

default["php5"]["key_ondrej"] = 'E5267A6C'
default["php5"]["key_skettler"] = 'C18789EA'
default["php5"]["key_ondrej_old"] = 'E5267A6C'

default["php5"]["version"] = '5.5'

default["php5"]['php_fpm_pool']["php_options"] = {'php_admin_flag[log_errors]' => 'on', 'php_admin_value[memory_limit]' => '512M', 'php_admin_value[error_reporting]' => 'E_ALL & ~E_DEPRECATED', 'php_admin_value[display_errors]' => 'On', 'php_admin_value[post_max_size]' => '64M', 'php_admin_value[upload_max_filesize]' => '64M'}


