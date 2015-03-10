
# certwhitelist 

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with certwhitelist](#setup)
    * [What certwhitelist affects](#what-certwhitelist-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with certwhitelist](#beginning-with-certwhitelist)
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

### Beginning with certwhitelist

Clone the repository:

https://github.com/DBMoUK/certwhitelist.git

## Usage

### THIS MODULE IS APPLICABLE TO PUPPET 3.7.0/3.7.1 - IF YOU USE THIS
### MODULE YOU *MUST* REVERT THE WHITELIST CHANGES YOU MAKE PRIOR TO 
### UPDATING TO PUPPET ENTERPRISE 3.7.2 DUE TO CHANGES IN THAT VERSION
### OF PUPPET - PLEASE READ THE INSTRUCTIONS CAREFULLY!

Firstly, add certificate FQDN names to the template:
 
certwhitelist/templates/ca.conf.whitelist.erb
 
In the form:
 
client-whitelist: [ <%= @console_client_certname %>, examplecert1.com, examplecert2.com ]
 
Separate the certificate FQDNs with a comma, and a following space, and remember to leave 
a trailing space before the closing square bracket.
 
It is important NOT to remove the Ruby class variable: <%= @console_client_certname %>
 
Apply the class using:
 
puppet apply certwhitelist/tests/add.pp


After the class has been applied to the 
Puppet Master [either CA or Compile Master], run puppet agent -t
confirm successful run and then re-add the Master to the Load Balancer
pool, if one is in use.


### VERY IMPORTANT NOTE:

BEFORE UPGRADING TO PUPPET 3.7.2 - PLEASE ENSURE THAT ON ALL PUPPET MASTERS
THAT WHITELISTING IS APPLIED TO - THE FOLLOWING CLASS IS APPLIED:

puppet apply certwhitelist/tests/revert.pp

This causes the template file /opt/puppet/share/puppet/modules/puppet_enterprise/templates/master/puppet_server/ca.conf.erb
to be replaced with a copy of the original ca.conf.erb file prior to amendment by whitelisting.

### IF YOU DO NOT APPLY: certwhitelist/tests/revert.pp PRIOR TO UPGRADING YOU *WILL* BREAK THE CONSOLE IN PUPPET ENTERPRISE 3.7.2!

 


## Reference

Class: certwhitelist/add.pp     # This class used to add cert FQDNs to whitelist.
Class: certwhitelist/revert.pp  # This class used to revert changes prior to upgrade to Puppet Enterprise 3.7.2
Class: certwhitelist/restart.pp # This class used internally to restart pe-puppetserver.




## Limitations

This module tested with CentOS 6.5x64 / Puppet Enterprise 3.7.0/3.7.2.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

Version 1.0
=======

