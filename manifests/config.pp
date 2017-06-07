class php5::config {

  augeas{'memcached_compression_threshold':
    context => "/files/${php5::params::php5_memcachedini}/PHP",
    changes => [
      "set memcached.compression_threshold ${php5::memcached_compression_threshold}",
    ],
    require => Package['php5.6-memcached']
  }

  include  php5::php5_cli::config
}
