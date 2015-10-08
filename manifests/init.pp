class python {
  $required = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [
      'python',
      'python-pip',
      'python-setuptools',
      'python-virtualenv',
      'python-virtualenv-clone',
      'python-virtualenvcontext',
      'python-virtualenvwrapper'
    ],
  }

  $path = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => '/var/virtual',
  }

  package { $required:
    ensure => latest
  }

  file { $path:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/usr/bin/pip-python':
    ensure  => 'link',
    owner   => 'root',
    group   => 'root',
    target  => "/usr/bin/pip",
    require => Package['python-pip'],
  }

}
