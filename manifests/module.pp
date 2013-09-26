define php5::module (

  $ensure = 'present',

) {

  package {$name:
    ensure => $ensure,
  }
}
