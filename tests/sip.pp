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

  # Manage sip with includes
  concat::fragment{'sip_includes':
    target  => '/etc/asterisk/sip.conf',
    content => '#include sip.d/*.conf',
    order   => 50,
  }
  $sip_d = '/etc/asterisk/sip.d'
  file{$sip_d:
    ensure  => directory,
    owner   => 'asterisk',
    group   => 'asterisk',
    mode    => '0750',
    recurse => true,
  }->
  file {"${sip_d}/myfriend.conf":
    content => '[myfriend]
secret=SOMESECRET
username=SOEMUSER
host=myfriend.domain.tld
allow=ulaw
context=ari
dtmfmode=rfc2833
insecure=very
dtmfmode=rfc2833
insecure=very
nat=yes
type=friend
directmedia=no
trustrpid=yes
callbackextension=SOMEEXTENSION
',
    notify  => Exec['asterisk-sip-reload'],
  }

}
