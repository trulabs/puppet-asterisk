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
# [*ari_enabled*]
#   String. Enable the ARI interface in Asterisk.
#   Options: 'yes', 'no'
#   Default: 'no'
#
# [*ast_dumpcore*]
#   String. Whether Asterisk should create core dumps ('no' is false, anything else is true)
#   Default: 'no'
#
# [*astetcdir*]
#   String. Directory configuration option in asterisk.conf
#   Default: OS specific
#
# [*astmoddir*]
#   String. Directory configuration option in asterisk.conf
#   Default: OS specific
#
# [*astvarlibdir*]
#   String. Directory configuration option in asterisk.conf
#   Default: OS specific
#
# [*astdbdir*]
#   String. Directory configuration option in asterisk.conf
#   Default: OS specific
#
# [*astkeydir*]
#   String. Directory configuration option in asterisk.conf
#   Default: OS specific
#
# [*astdatadir*]
#   String. Directory configuration option in asterisk.conf
#   Default: OS specific
#
# [*astagidir*]
#   String. Directory configuration option in asterisk.conf
#   Default: OS specific
#
# [*astspooldir*]
#   String. Directory configuration option in asterisk.conf
#   Default: OS specific
#
# [*astrundir*]
#   String. Directory configuration option in asterisk.conf
#   Default: OS specific
#
# [*astlogdir*]
#   String. Directory configuration option in asterisk.conf
#   Default: OS specific
#
# [*http_bindaddr*]
#   String. Interface to bind HTTP service.
#   Default: '0.0.0.0'
#
# [*http_enabled*]
#   String. Enable the HTTP interface in Asterisk. Should be 'yes' if you also enable ARI.
#   Options: 'yes', 'no'
#   Default: 'no'
#
# [*http_port*]
#   String. Port to bind HTTP service.
#   Default: '8088'
#
# [*manager_bindaddr*]
#   String. Interface to bind AMI service.
#   Default: '0.0.0.0'
#
# [*manager_enabled*]
#   String. Enable the Manager(AMI) interface in Asterisk.
#   Options: 'yes', 'no'
#   Default: 'no'
#
# [*manager_port*]
#   String. Port to bind AMI service.
#   Default: '5038'
#
# [*manager_webenabled*]
#   String. Web Enable the Manager(AMI) interface in Asterisk.
#   Options: 'yes', 'no'
#   Default: 'no'
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
#   Default: 'no'
#
# [*tcpbindaddr*]
#   String. Interface to bind TCP
#   Default: '0.0.0.0'
#
# [*tlsenable*]
#   String. Whether to enable TLS ('no' to disable)
#   Default: 'no'
#
# [*tlsbindaddr*]
#   String. Interface to bind TLS
#   Default: '0.0.0.0:5061'
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
  $service_enable      = $asterisk::params::service_enable,
  $service_ensure      = $asterisk::params::service_ensure,
  $service_manage      = $asterisk::params::service_manage,
  $package_ensure      = $asterisk::params::package_ensure,
  $package_name        = $asterisk::params::package_name,
  $manage_config       = $asterisk::params::manage_config,
  $ari_enabled         = $asterisk::params::ari_enabled,
  $ast_dumpcore        = $asterisk::params::ast_dumpcore,
  $astetcdir           = $asterisk::params::astetcdir,
  $astmoddir           = $asterisk::params::astmoddir,
  $astvarlibdir        = $asterisk::params::astvarlibdir,
  $astdbdir            = $asterisk::params::astdbdir,
  $astkeydir           = $asterisk::params::astkeydir,
  $astdatadir          = $asterisk::params::astdatadir,
  $astagidir           = $asterisk::params::astagidir,
  $astspooldir         = $asterisk::params::astspooldir,
  $astrundir           = $asterisk::params::astrundir,
  $astlogdir           = $asterisk::params::astlogdir,
  $http_enabled        = $asterisk::params::http_enabled,
  $http_bindaddr       = $asterisk::params::http_bindaddr,
  $http_port           = $asterisk::params::http_port,
  $manager_bindaddr    = $asterisk::params::manager_bindaddr,
  $manager_enabled     = $asterisk::params::manager_enabled,
  $manager_port        = $asterisk::params::manager_port,
  $manager_webenabled  = $asterisk::params::manager_webenabled,
  $rtpstart            = $asterisk::params::rtpstart,
  $rtpend              = $asterisk::params::rtpend,
  $udpbindaddr         = $asterisk::params::udpbindaddr,
  $tcpenable           = $asterisk::params::tcpenable,
  $tcpbindaddr         = $asterisk::params::tcpbindaddr,
  $tlsenable           = $asterisk::params::tlsenable,
  $tlsbindaddr         = $asterisk::params::tlsbindaddr,
  $tlscertfile         = $asterisk::params::tlscertfile,
  $tlsprivatekey       = $asterisk::params::tlsprivatekey,
  $tlscafile           = $asterisk::params::tlscafile,
  $tlscapath           = $asterisk::params::tlscapath,
  $tlsdontverifyserver = $asterisk::params::tlsdontverifyserver,
) inherits asterisk::params {

  validate_string($package_ensure, $package_name)
  validate_bool($service_enable, $service_manage, $manage_config)
  validate_string($manager_enabled, $manager_webenabled, $manager_bindaddr, $manager_port)
  validate_string($ari_enabled, $http_enabled, $http_bindaddr, $http_port)
  validate_string($udpbindaddr, $tcpenable, $tcpbindaddr)
  validate_string($tlsenable, $tlsbindaddr, $tlscertfile)
  validate_string($tlsprivatekey, $tlscafile, $tlscapath, $tlsdontverifyserver)

  class { '::asterisk::install':
    package_ensure  => $package_ensure,
    package_name    => $package_name,
  } ->
  class { '::asterisk::config':
    manage_config       => $manage_config,
    ari_enabled         => $ari_enabled,
    ast_dumpcore        => $ast_dumpcore,
    astetcdir           => $astetcdir,
    astmoddir           => $astmoddir,
    astvarlibdir        => $astvarlibdir,
    astdbdir            => $astdbdir,
    astkeydir           => $astkeydir,
    astdatadir          => $astdatadir,
    astagidir           => $astagidir,
    astspooldir         => $astspooldir,
    astrundir           => $astrundir,
    astlogdir           => $astlogdir,
    http_bindaddr       => $http_bindaddr,
    http_enabled        => $http_enabled,
    http_port           => $http_port,
    manager_bindaddr    => $manager_bindaddr,
    manager_enabled     => $manager_enabled,
    manager_port        => $manager_port,
    manager_webenabled  => $manager_webenabled,
    rtpstart            => $rtpstart,
    rtpend              => $rtpend,
    udpbindaddr         => $udpbindaddr,
    tcpenable           => $tcpenable,
    tcpbindaddr         => $tcpbindaddr,
    tlsenable           => $tlsenable,
    tlsbindaddr         => $tlsbindaddr,
    tlscertfile         => $tlscertfile,
    tlsprivatekey       => $tlsprivatekey,
    tlscafile           => $tlscafile,
    tlscapath           => $tlscapath,
    tlsdontverifyserver => $tlsdontverifyserver,
  }  ->
  class { '::asterisk::service':
    service_ensure => $service_ensure,
    service_manage => $service_manage,
    service_enable => $service_enable,
  }
}
