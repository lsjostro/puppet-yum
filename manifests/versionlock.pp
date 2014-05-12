define yum::versionlock ($version = '1.0-1',
                         $ensure = 'present'
) {

  $version_lock_list = '/etc/yum/pluginconf.d/versionlock.list'

  case $ensure {
    present: {
      exec { "yum_versionlock_${name}":
        command => "yum versionlock delete *${name}-*; yum clean all; yum versionlock ${name}-${version}",
        unless  => "grep -q '${name}-${version}' ${version_lock_list}",
        logoutput => true,
        path    => ["/bin", "/usr/bin"],
        require => Package["yum-plugin-versionlock"],
      }
    }
    absent: {
      exec { "yum_versionlock_${name}":
        command => "yum versionlock delete *${name}-*",
        onlyif  => "grep -q '${name}' ${version_lock_list}",
        logoutput => true,
        path    => ["/bin", "/usr/bin"],
        require => Package["yum-plugin-versionlock"],
      }
    }
  }
}
