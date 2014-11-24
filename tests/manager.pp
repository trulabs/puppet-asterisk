# Test the manager user configuration
node default {
  class { '::asterisk':
    service_manage     => true,
    service_ensure     => 'running',
    tcpenable          => 'yes',
    manage_config      => true,
    manager_enabled    => 'yes',
    manager_webenabled => 'yes',
  }
  # Add an AMI user
  ::asterisk::config::user{'/etc/asterisk/manager.conf':
    user        => 'manager_user',
    secret      => 'manager_secret',
    read        => 'all',
    write       => 'all',
    permit      => ['127.0.0.1/255.255.255.255'],
    deny        => ['192.168.1.0/255.255.255.0','172.16.0.0/255.240.0.0'],
    eventfilter => ['!Event: RTCP*','!Variable: RTPAUDIOQOS*'],
  }
}
