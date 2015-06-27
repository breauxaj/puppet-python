define python::virtual (
  $user = 'deploy',
  $group = 'deploy'
) {
  $path = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => '/var/virtual',
  }

  file { "${path}/${name}":
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0775',
  }

  exec { 'deploy-python':
    path    => '/bin:/usr/bin',
    command => "virtualenv --no-site-packages ${path}/${name} ; chown -R ${user}:${group} ${path}/${name}",
    cwd     => $path,
    creates => "${path}/${name}/bin/python",
    require => File[ "${path}/${name}" ],
  }

}
