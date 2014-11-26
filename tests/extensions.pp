# Test the manager user configuration
node default {
  class { '::asterisk':
    service_manage   => true,
    service_ensure   => 'running',
    tcpenable        => 'yes',
    manage_config    => true,
    manager_enabled  => 'yes',
    ext_writeprotect => 'yes',
    ext_includes     => ['extensions.d/*.conf',],
  }

  $extensions_d = '/etc/asterisk/extensions.d'
  file{$extensions_d:
    ensure  => directory,
    owner   => 'asterisk',
    group   => 'asterisk',
    mode    => '0750',
    recurse => true,
  }->
  file {"${extensions_d}/adhearsion.conf":
    owner   => 'asterisk',
    group   => 'asterisk',
    mode    => '0640',
    content => '[adhearsion]
exten       => _.,1,AGI(agi:async)

[adhearsion-redirect]
exten       => 1,1,AGI(agi:async)',
    notify  => Service['asterisk']
  }

  # Add an AMI user
  ::asterisk::config::user{'/etc/asterisk/manager.conf':
    user    => 'manager_user',
    secret  => 'manager_secret',
  }
}
