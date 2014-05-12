class yum() {
  package {"yum-plugin-versionlock":
    ensure  => installed,
  }
}
