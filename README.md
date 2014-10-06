puppet-asterisk
===============

## Description

Puppet module for Asterisk


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

Author
------

    Truphone Labs
    Giacomo Vacca <giacomo.vacca@gmail.com>

License
-------

See LICENSE file.

##Limitations

This module has been built and tested with Puppet 2.7.

The module has been tested on:
* Debian 7

##Tests

Run tests with:
    sudo puppet apply -v tests/init.pp --modulepath modules/:/etc/puppet/modules --show_diff --noop

##Contributors
The list of contributors can be found at: [https://github.com/trulabs/puppet-asterisk/graphs/contributors](https://github.com/trulabs/puppet-asterisk/graphs/contributors)
