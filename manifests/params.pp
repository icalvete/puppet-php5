class php5::params {

  $env      = $environment
  $timezone = 'Europe/Madrid'

  $phalcon_support = {
    'Debian' => {
      'saucy'  => true,
      'trusty' => true,
      'xenial' => true,
    }
  }

  $syslog_facility     = 'local4'
  $syslog_facility_php = 'LOG_LOCAL4'

  # log_level values can be alert, error, warning, notice, debug
  $log_level = 'warning'

  $file_uploads_size  = '10M'
  $max_execution_time = '15'
  $memory_limit       = '32M'

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {
      $php5_package      = 'php5.6'
      $php5_fpm_service  = 'php5.6-fpm'
      $php5_fpm_package  = 'php5.6-fpm'

      case $::lsbdistcodename {
        /^(saucy|trusty|xenial)/: {
          $php5_modules = ['php5.6-curl','php5.6-mysqlnd','php5.6-memcached', 'php5.6-json', 'php5.6-mcrypt', 'php5.6-mongo', 'php5.6-gd', 'php5.6-mbstring', 'php5.6-bcmath', 'php5.6-xml', 'php5.6-zip', 'php-yaml']
        }
        default: {
          $php5_modules = ['php5.6-curl','php5.6-mysqlnd','php5.6-memcached', 'php5.6-json', 'php5.6-mcrypt']
        }
      }

      $php5_cli_phpini   = '/etc/php/5.6/cli/php.ini'
      $php5_cli_phpconf  = '/etc/php/5.6/cli/conf.d'
      $php5_includepath  = '/usr/share/php'
      $php5_fpm_phpini   = '/etc/php/5.6/fpm/php.ini'
      $php5_fpm_phpconf  = '/etc/php/5.6/fpm/conf.d'
      $php5_fpm_conf     = '/etc/php/5.6/fpm/php-fpm.conf'
      $php5_fpm_www_pool = '/etc/php/5.6/fpm/pool.d/www.conf'
      $extension_dir     = '/usr/lib/php/'
    }
    /^(RedHat|CentOS)$/: {
      $php5_package      = 'php'
      $php5_fpm_service  = 'php-fpm'
      $php5_fpm_package  = 'php-fpm'
      $php5_cli_phpini   = 'etc/php.ini'
      $php5_includepath  = '/usr/share/php'
      $php5_fpm_phpini   = '/etc/php.ini'
      $php5_fpm_phpconf  = '/etc/php5/conf.d'
      $php5_fpm_conf     = '/etc/php-fpm.d/fpm.conf'
      $php5_fpm_www_pool = '/etc/php-fpm.d/www.conf'
      $extension_dir     = '/usr/lib64/php/modules/'
    }
    default: {
      fail ("${::operatingsystem} not supported.")
    }
  }
      $php5_memcachedini               = "/etc/php/5.6/mods-available/memcached.ini"
      $memcached_compression_threshold = 15000
}
