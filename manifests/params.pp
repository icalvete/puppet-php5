class php5::params {

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {
      $php5_package     = 'php5'
      $php5_fpm_service = 'php5-fpm'
      $php5_fpm_package = 'php5-fpm'
      $php5_modules     = ['php5-curl','php5-mysqlnd']
      $php5_cli_phpini  = 'etc/php5/cli/php.ini'
      $php5_includepath = '/usr/share/php5'
      $php5_fpm_phpini  = '/etc/php5/fpm/php.ini'
    }
    /^(RedHat|CentOS)$/: {
      $php5_package     = 'php'
      $php5_fpm_service = 'php-fpm'
      $php5_fpm_package = 'php-fpm'
      $php5_cli_phpini  = 'etc/php.ini'
      $php5_includepath = '/usr/share/php'
      $php5_fpm_phpini  = '/etc/php.ini'
    }
    default: {
      fail ("${::operatingsystem} not supported.")
    }
  }
}
