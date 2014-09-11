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

TODO: Something about Asterisk HERE TODO TODO TODO

Setup
-----

Add:

    include 'asterisk'

in your node definition.

Run
---
    sudo puppet apply -v environments/ENVIRONMENT/manifests/site.pp --modulepath modules/:/etc/puppet/modules/ --show_diff --noop

Install a 3rd party module
--------------------------

    sudo puppet module install

Run puppet-lint
---------------

    puppet-lint --no-80chars-check --with-filename modules/asterisk/manifests/

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

##Contributors
The list of contributors can be found at: [https://github.com/trulabs/puppet-asterisk/graphs/contributors](https://github.com/trulabs/puppet-asterisk/graphs/contributors)
