
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

Firstly, add certificate FQDN names to the template:

addcertwhitelist/templates/ca.conf.erb

In the form:

client-whitelist: [ <%= @console_client_certname %>, examplecert1.com, examplecert2.com ]

Separate the certificate FQDNs with a comma and a following space.

It is important NOT to remove the Ruby class variable: <%= @console_client_certname %>

Copy the template file in addcertwhitelist/templates/ca.conf.erb to 
addcertwhitelist/files/ca.conf.erb after editing.

Apply the class using:

puppet apply addcertwhitelist/tests/init.pp

### Setup Requirements 

Take the Puppet Master you wish to update out of its Load Balancer pool 
before updaing the certificate whitelist.

### Beginning with addcertwhitelist

The very basic steps needed for a user to get the module up and running.

If your most recent release breaks compatibility or requires particular steps
for upgrading, you may wish to include an additional section here: Upgrading
(For an example, see http://forge.puppetlabs.com/puppetlabs/firewall).

## Usage

Firstly, add certificate FQDN names to the template:
 
addcertwhitelist/templates/ca.conf.erb
 
In the form:
 
client-whitelist: [ <%= @console_client_certname %>, examplecert1.com, examplecert2.com ]
 
Separate the certificate FQDNs with a comma and a following space.
 
It is important NOT to remove the Ruby class variable: <%= @console_client_certname %>
 
Copy the template file in addcertwhitelist/templates/ca.conf.erb to 
addcertwhitelist/files/ca.conf.erb after editing.
 
Apply the class using:
 
puppet apply addcertwhitelist/tests/init.pp


When the Puppetserver daemon has restarted, the Master may be checked
by invoking an agent run with: puppet agent -t and then placed back in
a load balancer pool.


## Reference

Class: addcertwhitelist/init.pp

## Limitations

This module tested with CentOS 6.5x64 / Puppet Enterprise 3.7.0

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

Version 0.1
=======

