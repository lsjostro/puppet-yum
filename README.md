## Yum Version lock hack
### Example:
```
  $version = "1.0.1-1.el6"
  include yum
  $yum_version_lock = $version ? {
    latest    => "absent",
    installed => "absent",
    default   => "present",
  }

  yum::versionlock {'elasticsearch':
    ensure  => $yum_version_lock,
    version => "${version}",
  }

  package { 'elasticsearch':
    ensure  => $version,
    require => Exec["yum_versionlock_elasticsearch"]
  }
```
