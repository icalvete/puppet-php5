class php5::params {

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {
      $php5_fpm_service = 'php5-fpm'
      $curl             = 'php5-curl'
      $mysqlnd          = 'php5-mysqlnd'
    }
    default: {
      fail ("${::operatingsystem} not supported.")
    }
  }
}
