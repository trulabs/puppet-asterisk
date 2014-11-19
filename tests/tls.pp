# Test support for TLS
node 'default' {
  class { '::asterisk':
    service_manage => true,
    service_enable => true,
    service_ensure => 'running',
    tcpenable      => 'yes',
    tlsenable      => 'yes',
  }
}

