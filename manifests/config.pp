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
  $ari_enabled,
  $ast_dumpcore,
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
) inherits asterisk {
  File {
    owner => 'root',
    group => 'root',
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
      owner   => 'asterisk',
      group   => 'asterisk',
      path    => "${astetcdir}/asterisk.conf",
      content => template('asterisk/asterisk.conf.erb'),
      notify  => Service['asterisk'], # restart asterisk when asterisk.conf changes
    }

    file { "${astetcdir}/rtp.conf":
      ensure  => file,
      owner   => 'asterisk',
      group   => 'asterisk',
      path    => "${astetcdir}/rtp.conf",
      content => template('asterisk/rtp.conf.erb'),
      notify  => Service['asterisk'], # restart asterisk when rtp.conf changes
    }

    file { "${astetcdir}/sip.conf":
      ensure  => file,
      owner   => 'asterisk',
      group   => 'asterisk',
      path    => "${astetcdir}/sip.conf",
      content => template('asterisk/sip.conf.erb'),
      notify  => Exec['asterisk-sip-reload'],
    }

    # Default settings for all config files created with concat
    Concat {
      owner  => 'asterisk',
      group  => 'asterisk',
      mode   => '0440',
      warn   => false,
      notify => Service['asterisk'],
    }

    # Manager/AMI configuration
    concat { "${astetcdir}/manager.conf": }
    concat::fragment { 'manager_header':
      target  => "${astetcdir}/manager.conf",
      content => template('asterisk/manager.conf.erb'),
      order   => 1,
    }

    # HTTP configuration
    concat { "${astetcdir}/http.conf": }
    concat::fragment { 'http_header':
      target  => "${astetcdir}/http.conf",
      content => template('asterisk/http.conf.erb'),
      order   => 1,
    }

    # Validation step
    if ( $ari_enabled == 'yes' and $http_enabled == 'no') {
      warning("ARI is enabled but HTTP is not. ARI will not be available.")
    }
    # ARI configuration
    concat{ "${astetcdir}/ari.conf": }
    concat::fragment { 'ari_header':
      target  => "${astetcdir}/ari.conf",
      content => template('asterisk/ari.conf.erb'),
      order   => 1,
    }

    # Extensions
    concat {"${astetcdir}/extensions.conf": }
    concat::fragment {'extensions_general':
      target  => "${astetcdir}/extensions.conf",
      content => template('asterisk/extensions.conf.general.erb'),
      order   => 5,
    }

    # TODO /etc/init.d/asterisk
    # TODO /etc/logrotate.d/asterisk
  }

  # Ask Asterisk to reload the SIP configuration
  exec { 'asterisk-sip-reload':
    command     => '/usr/sbin/asterisk -rx "sip reload"',
    refreshonly => true,
  }
}
