class python::rhel7 (
  $version = '2.7'
){
  case $version {
    '3.4': {
      $required = $::operatingsystem ? {
        /(?i-mx:centos|fedora|redhat|scientific)/ => [
          'python',
          'python-pip',
          'python34',
        ],
      }

    }
    default: {
      $required = $::operatingsystem ? {
        /(?i-mx:centos|fedora|redhat|scientific)/ => [
          'python',
          'python-pip'
        ],
      }

    }
  }

  $managed = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [
      'fabric',
      'pip',
      'setuptools',
      'virtualenv'
    ],
  }

  package { $required:
    ensure => latest
  }

  package { $managed:
    ensure   => latest,
    provider => 'pip'
  }

}