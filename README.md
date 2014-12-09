puppet-asterisk
===============

## Description

Install and configure Asterisk (http://www.asterisk.org/)


=======

Overview
--------

The asterisk module provides a simple interface for managing Asterisk deployments with Puppet.

Module Description
------------------

Asterisk is a free and open source framework for building communications applications
[http://www.asterisk.org/](http://www.asterisk.org/)
This module helps you installing and configuring Asterisk with Puppet.

Setup
-----

To install Asterisk with the default parameters:

    class { '::asterisk': }

(this will also install the default package version for the current distribution).

If you want a specific package version (must be available depending on apt sources configuration):

    class { '::asterisk':
        package_ensure => '<MY VERSION>',
    }

**On an empty host:**

    apt-get update && apt-get install -y puppet
    ## This will also pull puppetlabs-stdlib
    puppet module install trulabs-asterisk
    puppet apply -v /etc/puppet/modules/asterisk/tests/init.pp --show_diff --noop

Parameters
----------


#####`service_enable`

Enable Asterisk.

#####`service_ensure`

Ensure the service is running or stopped.

#####`service_manage`

Whether Puppet should manage Asterisk as a service.

#####`package_ensure`

What the asterisk package version should be (including present, latest, absent).

#####`package_name`

Name of the asterisk package.

#####`manage_config`

Take care of configuration files, or delegate to something else external.

#####`ari_enabled`

Enable the Asterisk Restful Interface (ARI) ('yes' or 'no').

#####`ast_dump_core`

Create core dumps ('no' is false, everything else true).

#####`ast*dir`

Resource directories specified in the `asterisk.conf` file. Used to
override defaults: `astetcdir, astetcdir, astmoddir, astvarlibdir,
astdbdir, astkeydir, astdatadir, astagidir, astspooldir, astrundir,
astlogdir`.

#####`http_bindaddr`

Bind address for the Asterisk HTTP interface ('0.0.0.0')

#####`http_enabled`

Enable the Asterisk HTTP interface ('yes' or 'no').

#####`http_port`

TCP Port for the Asterisk HTTP interface ('8088').

#####`manager_bindaddr`

Bind address for the Asterisk Manager Interface (AMI) ('0.0.0.0')

#####`manager_enabled`

Enable the Asterisk Manager Interface (AMI) ('yes' or 'no').

#####`manager_port`

TCP Port for the Asterisk Manager Interface (AMI) ('5038').

#####`manager_webenabled`

Web Enable the Asterisk Manager Interface (AMI) ('yes' or 'no').

#####`rtpstart`

Lower limit for RTP port range.

#####`rtpend`

Upper limit for RTP port range.

#####`udpbindaddr`

Interface (with optional port) where to bind UDP.

#####`tcpenable`

Enable TCP ('yes' or 'no').

#####`tcpbindaddr`

Interface (with optional port) where to bind TCP.

#####`tlsenable`

Enable TLS ('yes' or 'no').

#####`tlsbindaddr`

Interface (with optional port) where to bind TLS.

#####`tlscertfile`

Path for TLS certificate.

#####`tlsprivatekey`

Path for TLS private key file.

#####`tlscafile`

Path for TLS CA file..

#####`tlscapath`

Path for TLS CA files folder.

#####`tlsdontverifyserver`

As TLS client, verify or not the server certificate ('yes' or 'no').


Author
------

    Truphone Labs
    Giacomo Vacca <giacomo.vacca@gmail.com>

License
-------

See LICENSE file.

##Limitations

The module has been tested on:
* Debian 7 (Wheezy) with Puppet 2.7 and 3.7
* Ubuntu 14.04 (Trusty) with Puppet 3.4 and 3.7
* OpenBSD 5.6 -current with Puppet 3.7.3

##Tests

Run tests from the tests/ folder, e.g.:
    sudo puppet apply -v tests/init.pp --modulepath modules/:/etc/puppet/modules --show_diff --noop

### Caveat: puppetlabs/concat
In order to successfully run a `--noop` test with the
`puppetlabs/concat` module, you must first run a successful concat
test so the module can compile a local shell script. A simple test
might be:

    # test-concat.pp
    node default {
        concat {'/tmp/foo.txt':}
        concat::fragment {'foo.txt':
            target  => '/tmp/foo.txt',
            content => 'bar',
        }
    }

##Contributors
The list of contributors can be found at: [https://github.com/trulabs/puppet-asterisk/graphs/contributors](https://github.com/trulabs/puppet-asterisk/graphs/contributors)
