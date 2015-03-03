
# addcertwhitelist 

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with addcertwhitelist](#setup)
    * [What addcertwhitelist affects](#what-addcertwhitelist-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with addcertwhitelist](#beginning-with-addcert_whitelist)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module allows the whitelisting of one or more certificates against the
Puppet Master /production/certificate_status/ endpoint.

The module patches the default template for:
/etc/puppetlabs/puppetserver/conf/ca.conf

It affects /opt/puppet/share/puppet/modules/puppet_enterprise/templates/
master/puppetserver/ca.conf.erb

## Module Description

The module patches the template used to generate:
/etc/puppetlabs/puppetserver/conf/ca.conf

The affected template is:
/opt/puppet/share/puppet/modules/puppet_enterprise/templates/master/
puppetserver/ca.conf.erb

## Setup

## Please Read and Follow These Instructions Carefully!


## This module should NOT be used to classify a Puppet Master.

### Setup Requirements 

Take the Puppet Master you wish to update out of its Load Balancer pool 
before updating the certificate whitelist.

### Beginning with addcertwhitelist

Clone the repository:

https://github.com/DBMoUK/addcertwhitelist.git

## Usage

Firstly, add certificate FQDN names to the template:
 
addcertwhitelist/files/ca.conf.erb
 
In the form:
 
client-whitelist: [ <%= @console_client_certname %>, examplecert1.com, examplecert2.com ]
 
Separate the certificate FQDNs with a comma, and a following space, and remember to leave 
a trailing space before the closing square bracket.
 
It is important NOT to remove the Ruby class variable: <%= @console_client_certname %>
 
Apply the class using:
 
puppet apply addcertwhitelist/tests/init.pp


After the class has been applied to the 
Puppet Master [either CA or Compile Master], run puppet agent -t
confirm successful run and then re-add the Master to the Load Balancer
pool, if one is in use.


## Reference

Class: addcertwhitelist/init.pp

## Limitations

This module tested with CentOS 6.5x64 / Puppet Enterprise 3.7.0

## If you Upgrade Puppet Enterprise on your Puppet Master nodes, you must 
## reapply this class post-upgrade to your Puppet Master nodes as the
## source template will be overwritten via the upgrade.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

Version 0.1
=======

