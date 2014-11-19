# Test one of the most basic configurations
node 'default' {
  class { '::asterisk':
    service_manage => true,
    service_enable => true,
    service_ensure => 'running',
  }
}

