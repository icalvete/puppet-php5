class php5::php5_cli::install {

  include php5::modules

  package {'php5.6-cli':
    ensure => present,
  }
}
