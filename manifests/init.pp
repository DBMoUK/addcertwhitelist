class addcertwhitelist
{
  $templatepath             = '/opt/puppet/share/puppet/modules/puppet_enterprise/templates/master/puppetserver'
  $puppetserver_file_path   = '/etc/puppetlabs/puppetserver/conf.d'
  $console_client_certname  = 'pe-internal-dashboard'

  file { "${templatepath}/ca.conf.erb":
    ensure => file,
    owner  => 'pe-puppet',
    group  => 'pe-puppet',
    mode   => '0444',
    source => 'puppet:///modules/addcertwhitelist/ca.conf.erb',
    before => File["${puppetserver_file_path}/ca.conf"],
  }

  file { "${puppetserver_file_path}/ca.conf":
    ensure  => file,
    owner   => 'pe-puppet',
    group   => 'pe-puppet',
    mode    => '0640',
    content => template('addcertwhitelist/ca.conf.erb'),
    notify  => Exec['restart-puppetserver'],
  }


  exec {'restart-puppetserver':
    path        => '/sbin',
    command     => 'service pe-puppetserver restart',
    refreshonly => true,
  }
}


