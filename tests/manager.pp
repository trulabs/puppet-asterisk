# Test the manager user configuration
node default {
  class { '::asterisk':
    manage_config   => true,
    manager_enabled => 'yes',
  }
  # Add an AMI user
  asterisk::config::user('/etc/asterisk/manager.conf','asterisk','asterisk')
}
