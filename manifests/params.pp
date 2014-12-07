# params.pp
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

class asterisk::params {
  $service_enable      = false
  $service_ensure      = 'running'
  $service_manage      = false
  $package_ensure      = 'latest'
  $package_name        = 'asterisk'
  $manage_config       = true
  $ari_enabled         = 'no'
  $ast_dumpcore        = 'no'
  $http_bindaddr       = '127.0.0.1'
  $http_enabled        = 'no'
  $http_port           = '8088'
  $manager_bindaddr    = '127.0.0.1'
  $manager_enabled     = 'no'
  $manager_port        = '5038'
  $manager_webenabled  = 'no'
  $rtpstart            = '10000'
  $rtpend              = '20000'
  $udpbindaddr         = '0.0.0.0'
  $tcpenable           = 'no'
  $tcpbindaddr         = '0.0.0.0'
  $tlsenable           = 'no'
  $tlsbindaddr         = '0.0.0.0'
  $tlscertfile         = 'asterisk.pem'
  $tlsprivatekey       = 'asterisk.pem'
  $tlscafile           = ''
  $tlscapath           = ''
  $tlsdontverifyserver = 'no'

  case $::osfamily {
    'Debian': {
      $asteriskuser = 'asterisk'
      $asteriskgroup = 'asterisk'
      $astetcdir = '/etc/asterisk'
      $astbinary = '/usr/sbin/asterisk'
      $astmoddir = '/usr/lib/asterisk/modules'
      $astvarlibdir = '/var/lib/asterisk'
      $astdbdir ='/var/lib/asterisk'
      $astkeydir = '/var/lib/asterisk'
      $astdatadir = '/usr/share/asterisk'
      $astagidir = '/usr/share/asterisk/agi-bin'
      $astspooldir = '/var/spool/asterisk'
      $astrundir = '/var/run/asterisk'
      $astlogdir = '/var/log/asterisk'
    }
    'RedHat': {
      $asteriskuser = 'asterisk'
      $asteriskgroup = 'asterisk'
      $astbinary = '/usr/sbin/asterisk'
      $astetcdir = '/etc/asterisk'
      $astmoddir = $::architecture ? {
        /64/ => '/usr/lib64/asterisk/modules',
        default => '/usr/lib/asterisk/modules',
      }
      $astvarlibdir = '/var/lib/asterisk'
      $astdbdir ='/var/lib/asterisk'
      $astkeydir = '/var/lib/asterisk'
      $astdatadir = '/var/lib/asterisk'
      $astagidir = '/var/lib/asterisk/agi-bin'
      $astspooldir = '/var/spool/asterisk'
      $astrundir = '/var/run/asterisk'
      $astlogdir = '/var/log/asterisk'
    }
    'OpenBSD': {
      $asteriskuser = '_asterisk'
      $asteriskgroup = '_asterisk'
      $astbinary = '/usr/sbin/asterisk'
      $astetcdir = '/etc/asterisk'
      $astmoddir = '/usr/local/lib/asterisk/modules'
      $astvarlibdir = '/usr/local/share/asterisk'
      $astkeydir = '/etc/asterisk'
      $astdbdir = '/var/db/asterisk'
      $astdatadir = '/usr/local/share/asterisk'
      $astagidir = '/usr/local/share/asterisk/agi-bin'
      $astspooldir = '/var/spool/asterisk'
      $astrundir = '/var/run/asterisk'
      $astlogdir = '/var/log/asterisk'
    }
    default: {
      warning("OS ${::osfamily} default paths for ast*dir pramaters not provided.")
    }
  }

  # Extensions configuration
  $ext_static = 'yes'
  $ext_writeprotect = 'yes'
  $ext_autofallthrough = 'yes'
  $ext_patternmatchnew = 'no'
  $ext_clearglobalvars = 'no'
  $ext_userscontext = 'default'
  $ext_includes = []
  $ext_execs = []
}
