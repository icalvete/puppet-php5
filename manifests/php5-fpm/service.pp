class php5::php5-fpm::service {

  service { $php5::params::php5_fpm_service:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
  }
}
