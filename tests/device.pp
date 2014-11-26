# Test the manager user configuration
node default {
  class { '::asterisk':
    service_manage   => true,
    service_ensure   => 'running',
    tcpenable        => 'yes',
    manage_config    => true,
    manager_enabled  => 'yes',
  }

  ::asterisk::config::device{'myfriend':
    target            => "${::asterisk::astetcdir}/sip.conf",
    type              => 'friend',
    username          => '1357',
    secret            => 'sillypassword',
    host              => 'myfriend.domain.tld',
    port              => '64391',
    permit            => ['192.168.1.0/255.255.255.0','172.17.3.0/255.255.254.0',] ,
    deny              => ['0.0.0.0/255.255.255.255',],
    callbackextension => '12337ACB27',
    disallow          => ['all'],
    allow             => ['ulaw'],
    require           => Class[::asterisk],
  }
}
