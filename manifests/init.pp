class python (
  $version = '2.6'
){
  case $version {
    '2.7': {
      $required = $::operatingsystem ? {
        /(?i-mx:centos|fedora|redhat|scientific)/ => [
          'python',
          'python-pip',
          'python-setuptools',
          'python-virtualenv',
          'python27',
          'python27-pip',
          'python27-setuptools',
          'python27-virtualenv'
        ],
      }

      yumrepo { 'puias-computational':
        mirrorlist     => 'http://puias.math.ias.edu/data/puias/computational/$releasever/$basearch/mirrorlist',
        failovermethod => 'priority',
        enabled        => '1',
        gpgcheck       => '1',
        gpgkey         => 'http://springdale.math.ias.edu/data/puias/6/x86_64/os/RPM-GPG-KEY-puias',
        descr          => 'PUIAS Computational Base $releasever - $basearch',
      }

      package { $required:
        ensure => latest,
        require => Yumrepo['puias-computational'],
      }

    }
    default: {
      $required = $::operatingsystem ? {
        /(?i-mx:centos|fedora|redhat|scientific)/ => [
          'python'
        ],
      }

      package { $required:
        ensure => latest
      }

    }
  }

  file { '/usr/bin/pip-python':
    ensure  => 'link',
    owner   => 'root',
    group   => 'root',
    target  => "/usr/bin/pip",
    require => Package['python-pip'],
  }

}
