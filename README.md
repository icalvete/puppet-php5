#puppet-php5

Puppet manifest to install and configure php5

[![Build Status](https://secure.travis-ci.org/icalvete/puppet-php5.png)](http://travis-ci.org/icalvete/puppet-php5)

## Actions:

* php5 + fpm for apache2
* php5 cli
* include phalcon module (Only for Ubuntu saucy)

##Requires:

* Only works on Ubuntu
* [hiera](http://docs.puppetlabs.com/hiera/1/index.html)
* [augeas](http://projects.puppetlabs.com/projects/1/wiki/puppet_augeas)
* https://github.com/icalvete/puppet-common but really only need:
  + common::add_env define.

##Examples:

Install apache2 with php5 + fpm (See http://php-fpm.org/)

Need https://github.com/icalvete/puppet-apache2

```puppet
    class roles::apache2_server (
      
      $ssl       = true,
      $passenger = true,
      
      ) inherits roles {
	      
      include apache2
      
      class {'php5':
        fpm => true
      }
      
      if $ssl {
        apache2::module {'ssl':
	  require => Class['apache2::install']
        }
      
        apache2::site {'default-ssl':
          require => Class['apache2::install']
        }
      }
     
      if $passenger {
        apache2::module {'passenger':
          require => Class['apache2::install']
        }
      }
    }
```

##TODO:

* Some values must be parametriced
* Documentation

##Authors:
		 
Israel Calvete Talavera <icalvete@gmail.com>
