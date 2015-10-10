class python (
  $version = '2.6'
){
  case $version {
    '3': {
      $required = $::operatingsystem ? {
        /(?i-mx:centos|fedora|redhat|scientific)/ => [
          'python',
          'python-pip',
          'python3',
        ],
      }
    }
    '2.7': {
      $required = $::operatingsystem ? {
        /(?i-mx:centos|fedora|redhat|scientific)/ => [
          'python',
          'python-pip',
          'python27',
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

  yumrepo { 'puias-computational':
    mirrorlist     => 'http://puias.math.ias.edu/data/puias/computational/$releasever/$basearch/mirrorlist',
    failovermethod => 'priority',
    enabled        => '1',
    gpgcheck       => '1',
    gpgkey         => 'http://springdale.math.ias.edu/data/puias/6/x86_64/os/RPM-GPG-KEY-puias',
    descr          => 'PUIAS Computational Base $releasever - $basearch',
  }

  $managed = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [
      'pip',
      'setuptools',
      'virtualenv'
    ],
  }

  package { $required:
    ensure => latest,
    require => Yumrepo['puias-computational'],
  }

  package { $managed:
    ensure   => latest,
    provider => 'pip'
    require  => File['/usr/bin/pip-python'],
  }

  file { '/usr/bin/pip-python':
    ensure  => 'link',
    owner   => 'root',
    group   => 'root',
    target  => "/usr/bin/pip",
    require => Package['python-pip'],
  }

}
