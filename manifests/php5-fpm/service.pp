class php5::php5-fpm::service {

  if versioncmp($operatingsystemrelease, '15.04') < 0 {

    $provider = 'upstart'
  } else{
  
    $provider = 'systemd'
  }

  service { $php5::params::php5_fpm_service:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    provider   => $provider
  }
}
