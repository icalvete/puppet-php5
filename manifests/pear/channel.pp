define php5::pear::channel (

  $ensure = 'present'

) {

  case $ensure {
    'present' : {
      exec{ "subcribe_${name}":
        command => "/usr/bin/pear channel-discover ${name}",
        unless  => "/usr/bin/pear channel-info ${name}",
      }
    }
    'absent': {
      exec{ "unsubcribe_${name}":
        command => "/usr/bin/pear channel-delete ${name}",
        onlyif  => "/usr/bin/pear channel-info ${name}",
      }
    }
    default:{}
  }
}

