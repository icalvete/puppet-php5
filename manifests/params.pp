class php5::params {

  $env      = $::environment
  $timezone = 'Europe/Madrid'

  $phalcon_support = {
    'Debian' => {
      'saucy'  => true,
      'trusty' => true,
    }
  }

  $syslog_facility     = 'local4'
  $syslog_facility_php = 'LOG_LOCAL4'

  $file_uploads_size = '10M'

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {
      $php5_package      = 'php5'
      $php5_fpm_service  = 'php5-fpm'
      $php5_fpm_package  = 'php5-fpm'

      case $::lsbdistcodename {
        /^(saucy|trusty)/: {
          $php5_modules = ['php5-curl','php5-mysqlnd','php5-memcached', 'php5-json', 'php5-mongo']
        }
        default: {
          $php5_modules = ['php5-curl','php5-mysqlnd','php5-memcached', 'php5-json']
        }
      }

      $php5_cli_phpini   = 'etc/php5/cli/php.ini'
      $php5_includepath  = '/usr/share/php5'
      $php5_fpm_phpini   = '/etc/php5/fpm/php.ini'
      $php5_fpm_phpconf  = '/etc/php5/fpm/conf.d'
      $php5_fpm_conf     = '/etc/php5/fpm/php-fpm.conf'
      $php5_fpm_www_pool = '/etc/php5/fpm/pool.d/www.conf'
      $extension_dir     = '/usr/lib/php5/'
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
}
