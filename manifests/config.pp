#config.pp
# === License
#
# Copyright (c) 2014, Truphone
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
#
# Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
# Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
# Neither the name of Truphone nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

class asterisk::config (
  $manage_config,
  $asteriskuser,
  $asteriskgroup,
  $ari_enabled,
  $ast_dumpcore,
  $astbinary,
  $astetcdir,
  $astmoddir,
  $astvarlibdir,
  $astdbdir,
  $astkeydir,
  $astdatadir,
  $astagidir,
  $astspooldir,
  $astrundir,
  $astlogdir,
  $http_bindaddr,
  $http_enabled,
  $http_port,
  $manager_bindaddr,
  $manager_enabled,
  $manager_port,
  $manager_webenabled,
  $register_sip,
  $rtpstart,
  $rtpend,
  $udpbindaddr,
  $tcpenable,
  $tcpbindaddr,
  $tlsenable,
  $tlsbindaddr,
  $tlscertfile,
  $tlsprivatekey,
  $tlscafile,
  $tlscapath,
  $tlsdontverifyserver,
  $ext_static,
  $ext_writeprotect,
  $ext_autofallthrough,
  $ext_patternmatchnew,
  $ext_clearglobalvars,
  $ext_userscontext,
  $ext_includes,
  $ext_execs,
  $queues_includes,
) inherits asterisk {
  File {
    owner => 'root',
    group => '0',
    mode  => '0640',
  }

  if ($manage_config) {
    if ($::osfamily == 'Debian') {
      file { '/etc/default/asterisk':
        ensure  => file,
        mode    => '0644',
        path    => '/etc/default/asterisk',
        content => template('asterisk/etc_default_asterisk.erb'),
        notify  => Service['asterisk'], # restart asterisk when this changes
      }
    }

    file { "${astetcdir}/asterisk.conf":
      ensure  => file,
      owner   => $asteriskuser,
      group   => $asteriskgroup,
      path    => "${astetcdir}/asterisk.conf",
      content => template('asterisk/asterisk.conf.erb'),
      notify  => Service['asterisk'], # restart asterisk when asterisk.conf changes
    }

    file { "${astetcdir}/rtp.conf":
      ensure  => file,
      owner   => $asteriskuser,
      group   => $asteriskgroup,
      path    => "${astetcdir}/rtp.conf",
      content => template('asterisk/rtp.conf.erb'),
      notify  => Service['asterisk'], # restart asterisk when rtp.conf changes
    }

    file { "${astetcdir}/queues.conf":
      ensure  => file,
      owner   => $asteriskuser,
      group   => $asteriskgroup,
      path    => "${astetcdir}/queues.conf",
      content => template('asterisk/queues.conf.erb'),
      notify  => Service['asterisk'], # restart asterisk when asterisk.conf changes
    }

    # Default settings for all config files created with concat
    Concat {
      owner  => $asteriskuser,
      group  => $asteriskgroup,
      mode   => '0440',
      warn   => false,
      notify => Service['asterisk'],
    }

    # SIP configuration
    concat {"${astetcdir}/sip.conf":
      notify => Exec['asterisk-sip-reload'],
    }
    concat::fragment { 'sip_general':
      target  => "${astetcdir}/sip.conf",
      content => template('asterisk/sip.conf.erb'),
      order   => '10',
    }
    concat::fragment { 'sip_authentication':
      target  => "${astetcdir}/sip.conf",
      content => template('asterisk/sip.conf.authentication.erb'),
      order   => '20',
    }
    concat::fragment { 'sip_devices':
      target  => "${astetcdir}/sip.conf",
      content => template('asterisk/sip.conf.devices.erb'),
      order   => '40',
    }

    # IAX configuration
    concat {"${astetcdir}/iax.conf":
      notify => Exec['asterisk-iax-reload'],
    }
    concat::fragment { 'iax_general':
      target  => "${astetcdir}/iax.conf",
      content => template('asterisk/iax.conf.erb'),
      order   => '10',
    }

    # Manager/AMI configuration
    concat { "${astetcdir}/manager.conf": }
    concat::fragment { 'manager_header':
      target  => "${astetcdir}/manager.conf",
      content => template('asterisk/manager.conf.erb'),
      order   => '1',
    }

    # HTTP configuration
    concat { "${astetcdir}/http.conf": }
    concat::fragment { 'http_header':
      target  => "${astetcdir}/http.conf",
      content => template('asterisk/http.conf.erb'),
      order   => '1',
    }

    # Validation step
    if ( $ari_enabled == 'yes' and $http_enabled == 'no') {
      warning('ARI is enabled but HTTP is not. ARI will not be available.')
    }
    # ARI configuration
    concat{ "${astetcdir}/ari.conf": }
    concat::fragment { 'ari_header':
      target  => "${astetcdir}/ari.conf",
      content => template('asterisk/ari.conf.erb'),
      order   => '1',
    }

    # Extensions
    concat {"${astetcdir}/extensions.conf": }
    concat::fragment {'extensions_general':
      target  => "${astetcdir}/extensions.conf",
      content => template('asterisk/extensions.conf.general.erb'),
      order   => '5',
    }

    # TODO /etc/init.d/asterisk
    # TODO /etc/logrotate.d/asterisk
  }

  # Ask Asterisk to reload the SIP configuration
  exec { 'asterisk-sip-reload':
    command     => "${astbinary} -rx 'sip reload'",
    refreshonly => true,
  }

  # Ask Asterisk to reload the IAX configuration
  exec { 'asterisk-iax-reload':
    command     => "${astbinary} -rx 'reload chan_iax2.so'",
    refreshonly => true,
  }
}
