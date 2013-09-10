class python {
  $required = $operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ 'python', 'python-pip', 'python-setuptools', 'python-virtualenv', 'python-virtualenv-clone', 'python-virtualenvcontext', 'python-virtualenvwrapper' ],
  }

  package { $required: ensure => latest }

  $path = $operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => '/var/virts',
  }

  file { $path:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

}

define python::instance ( $user = 'deploy',
                          $group = 'deploy' ) {
  $path = $operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => '/var/virts',
  }

  file { "$path/$name":
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0775',
  }

  exec { deploy-python:
    path    => '/bin:/usr/bin',
    command => "virtualenv --no-site-packages $path/$name ; chown -R $user:$group $path/$name",
    cwd     => $path,
    creates => "$path/$name/bin/python",
    require => File[ "$path/$name" ],
  }

}
