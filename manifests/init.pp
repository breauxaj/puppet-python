class python (
  $version = '2.6'
){
  case $::osfamily {
    'redhat': {
      case $::lsbmajdistrelease {
        '7': {
          class { 'python::rhel7':
            version => $version
          }
        }
        default: {
          class { 'python::rhel6':
            version => $version
          }
        }
      }
    }
    default: {
      notify { 'OS not supported by this module': }
    }
  }

}
