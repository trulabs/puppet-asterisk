#nodes.pp

node 'base_asterisk' {

  class { '::asterisk':
    service_manage => true,
    service_enable => true,
    service_ensure => 'running',
    tcpenable => 'yes',
  }
}

node 'debian7' inherits 'base_asterisk' {
}
