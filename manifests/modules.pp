define python::modules {
  include python

  $required = $title

  $depends = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ 'python-pip' ],
  }

  package { $required:
    ensure   => latest,
    provider => pip,
    require  => Package[$depends],
  }

}
