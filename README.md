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
node 'ubuntu01.smartpurposes.net' inherits test_defaults {
  class {'roles::apache2_server':
    php                    => true,
    file_uploads           => 'On',
    file_uploads_size      => '500M',
    max_execution_time_fpm => '60'
  }
}

node 'ubuntu02.smartpurposes.net' inherits test_defaults {
  class {'roles::apache2_server':
    php                    => 5,
    file_uploads           => 'On',
    file_uploads_size      => '500M',
    max_execution_time_fpm => '60'
  }
}
```

##TODO:

* Some values must be parametriced
* Documentation

##Authors:
		 
Israel Calvete Talavera <icalvete@gmail.com>
