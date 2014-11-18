# Test the manager user configuration
node default {
  class { '::asterisk':
    service_manage  => true,
    service_ensure  => 'running',
    tcpenable       => 'yes',
    manage_config   => true,
    manager_enabled => 'yes',
  }
  # Add an AMI user
  ::asterisk::config::user{'/etc/asterisk/manager.conf':
    user    => 'manager_user',
    secret  => 'manager_secret',
  }
}
