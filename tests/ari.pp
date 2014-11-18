# Test the manager user configuration
node default {
  class { '::asterisk':
    service_manage  => true,
    service_ensure  => 'running',
    tcpenable       => 'yes',
    manage_config   => true,
    ari_enabled     => 'yes',
    http_enabled    => 'yes',
  }
  # Add an ARI user
  ::asterisk::config::user{'/etc/asterisk/ari.conf':
    user   => 'ari_user',
    secret => 'ari_secret',
  }
}
