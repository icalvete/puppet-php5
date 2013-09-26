class php5::install {

  package {'php5':
    ensure => present
  }

  package {'libapache2-mod-php5':
    ensure => absent
  }

  package {'libapache2-mod-php5filter':
    ensure => absent
  }
}
