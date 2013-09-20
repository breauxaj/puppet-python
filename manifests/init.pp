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

  package { $required: ensure => latest }

  $path = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => '/var/virts',
  }

  file { $path:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

}
