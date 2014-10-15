# init.pp
# == Class: asterisk
#
# This module installs asterisk, configures it, and can ensure it is running
#
# === Examples
#
# * Installation:
#   class { 'asterisk': }
#
# === Authors
#
# * Giacomo Vacca <mailto:giacomo.vacca@truphone.com>
#
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
# 
# === Parameters
#
# [*service_enable*]
#   Boolean.
#   Default: false.
#
# [*service_ensure*]
#   String. Ensure the service is running or stopped.
#   Options: running, stopped
#   Default: running
# 
# [*service_manage*]
#   Boolean. Whether Puppet should manage this service.
#   Default: false
# 
# [*package_ensure*]
#   String. Ensure the package is present or not.
#   Options: present, latest, absent
#   Default: present
# 
# [*package_name*]
#   String. What package name to use for asterisk.
#   Default: asterisk
#
# [*manage_config*]
#   Boolean. Whether Puppet should manage the configuration files.
#   Default: true
# 
# [*ast_dumpcore*]
#   String. Whether Asterisk should create core dumps ('no' is false, anything else is true)
#   Default: no
# 
# [*rtpstart*]
#   String. Lower limit for RTP port range
#   Default: 10000
# 
# [*rtpend*]
#   String. Upper limit for RTP port range
#   Default: 20000
# 
# [*udpbindaddr*]
#   String. Interface to bind UDP
#   Default: 0.0.0.0
# 
# [*tcpenable*]
#   String. Whether to enable TCP ('no' to disable)
#   Default: no
# 
# [*tcpbindaddr*]
#   String. Interface to bind TCP
#   Default: 0.0.0.0
# 
# [*tlsenable*]
#   String. Whether to enable TLS ('no' to disable)
#   Default: no
# 
# [*tlsbindaddr*]
#   String. Interface to bind TLS
#   Default: 0.0.0.0:5061
# 
# [*tlscertfile*]
#   String. Path to TLS certificate
#   Default: './asterisk.pem'
# 
# [*tlsprivatekey*]
#   String. Path to TLS certificate private key
#   Default: './asterisk.pem'
# 
# [*tlscafile*]
#   String. Path to TLS CA certificate
#   Default: ''
# 
# [*tlscapath*]
#   String. Path to the path of TLS CA certificates folder
#   Default: ''
# 
# [*tlsdontverifyserver*]
#   String. When acting as TLS client, whether asterisk should verify the server certificate 'yes' or 'no'
#   Default: 'no'
# 
class asterisk(
  $service_enable = $asterisk::params::service_enable,
  $service_ensure = $asterisk::params::service_ensure,
  $service_manage = $asterisk::params::service_manage,
  $package_ensure = $asterisk::params::package_ensure,
  $package_name   = $asterisk::params::package_name,
  $manage_config  = $asterisk::params::manage_config,
  $ast_dumpcore   = $asterisk::params::ast_dumpcore,
  $rtpstart       = $asterisk::params::rtpstart,
  $rtpend         = $asterisk::params::rtpend,
  $udpbindaddr    = $asterisk::params::udpbindaddr,
  $tcpenable      = $asterisk::params::tcpenable,
  $tcpbindaddr    = $asterisk::params::tcpbindaddr,
  $tlsenable      = $asterisk::params::tlsenable,
  $tlsbindaddr    = $asterisk::params::tlsbindaddr,
  $tlscertfile    = $asterisk::params::tlscertfile,
  $tlsprivatekey  = $asterisk::params::tlsprivatekey,
  $tlscafile      = $asterisk::params::tlscafile,
  $tlscapath      = $asterisk::params::tlscapath,
  $tlsdontverifyserver = $asterisk::params::tlsdontverifyserver,
) inherits asterisk::params {

  validate_string($package_ensure, $package_name)
  validate_bool($service_enable, $service_manage, $manage_config)
  validate_string($udpbindaddr, $tcpenable, $tcpbindaddr)
  validate_string($tlsenable, $tlsbindaddr, $tlscertfile)
  validate_string($tlsprivatekey, $tlscafile, $tlscapath, $tlsdontverifyserver)

  class { '::asterisk::install':
    package_ensure  => $package_ensure,
    package_name    => $package_name,
  } ->
  class { '::asterisk::config':
    manage_config => $manage_config,
    ast_dumpcore  => $ast_dumpcore,
    rtpstart      => $rtpstart,
    rtpend        => $rtpend,
    udpbindaddr   => $udpbindaddr,
    tcpenable     => $tcpenable,
    tcpbindaddr   => $tcpbindaddr,
    tlsenable     => $tlsenable,
    tlsbindaddr   => $tlsbindaddr,
    tlscertfile   => $tlscertfile,
    tlsprivatekey => $tlsprivatekey,
    tlscafile     => $tlscafile,
    tlscapath     => $tlscapath,
    tlsdontverifyserver   => $tlsdontverifyserver,
  }  ->
  class { '::asterisk::service':
    service_ensure => $service_ensure,
    service_manage => $service_manage,
    service_enable => $service_enable,
  }
}
