Team and repository tags
========================

[![Team and repository tags](https://governance.openstack.org/tc/badges/puppet-tacker.svg)](https://governance.openstack.org/tc/reference/tags/index.html)

<!-- Change things from this point on -->

tacker
=======

#### Table of Contents

1. [Overview - What is the tacker module?](#overview)
2. [Module Description - What does the module do?](#module-description)
3. [Setup - The basics of getting started with tacker](#setup)
4. [Implementation - An under-the-hood peek at what the module is doing](#implementation)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Contributors - Those with commits](#contributors)
8. [Release Notes - Release notes for the project](#release-notes)
9. [Repository - The project source code repository](#repository)

Overview
--------

The tacker module is a part of [OpenStack](https://git.openstack.org), an effort by the OpenStack infrastructure team to provide continuous integration testing and code review for OpenStack and OpenStack community projects not part of the core software.  The module its self is used to flexibly configure and manage the NFV orchestration service for OpenStack.

Module Description
------------------

The tacker module is a thorough attempt to make Puppet capable of managing the entirety of tacker.  This includes manifests to provision region specific endpoint and database connections.  Types are shipped as part of the tacker module to assist in manipulation of configuration files.

Setup
-----

**What the tacker module affects**

* [Tacker](https://wiki.openstack.org/wiki/Tacker), the NFV orchestration service for OpenStack.

### Installing tacker

    tacker is not currently in Puppet Forge, but is anticipated to be added soon.  Once that happens, you'll be able to install tacker with:
    puppet module install openstack/tacker

### Beginning with tacker

To utilize the tacker module's functionality you will need to declare multiple resources.

Implementation
--------------

### tacker

tacker is a combination of Puppet manifest and ruby code to delivery configuration and extra functionality through types and providers.

Limitations
------------

* All the tacker types use the CLI tools and so need to be ran on the tacker node.

Beaker-Rspec
------------

This module has beaker-rspec tests

To run the tests on the default vagrant node:

```shell
bundle install
bundle exec rake acceptance
```

For more information on writing and running beaker-rspec tests visit the documentation:

* https://github.com/puppetlabs/beaker-rspec/blob/master/README.md

Development
-----------

Developer documentation for the entire puppet-openstack project.

* https://docs.openstack.org/puppet-openstack-guide/latest/

Contributors
------------

* https://github.com/openstack/puppet-tacker/graphs/contributors

Release Notes
-------------

* https://docs.openstack.org/releasenotes/puppet-tacker

Repository
----------

* https://git.openstack.org/cgit/openstack/puppet-tacker
