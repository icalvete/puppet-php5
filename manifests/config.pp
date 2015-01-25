class php5::config {

  include  php5::php5-cli::config
  
  if $environment == 'DEV' {
  
    file {'xdebug_config':
      ensure  => file,
      path    => "${php5::params::php5_fpm_phpconf}/20-xdebug.ini",
      content => template("${module_name}/xdebug.ini.erb"),
      mode    => '0644',
    }
  }
}
