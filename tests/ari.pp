# Test the manager user configuration
node default {
  class { '::asterisk':
    manage_config => true,
    ari_enabled   => 'yes',
    http_enabled  => 'yes',
  }
  # Add an AMI user
  asterisk::config::user('/etc/asterisk/ari.conf','asterisk','asterisk')
}
