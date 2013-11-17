class php5::install inherits php5::params {

	package { "$php5::params::php5_package" :
		ensure => present
	}

	case $::operatingsystem { 
	
		/^(Debian|Ubuntu)$/: {

			package {'libapache2-mod-php5':
				ensure => absent
			}

			package {'libapache2-mod-php5filter':
				ensure => absent
			}
		}
	}
}
