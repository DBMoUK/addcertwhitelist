class addcertwhitelist
{
  $templatepath             = '/opt/puppet/share/puppet/modules/puppet_enterprise/templates/master/puppetserver'
  $console_client_certname  = 'pe-internal-dashboard'

  file { "${templatepath}/ca.conf.erb":
    ensure => file,
    owner  => 'pe-puppet',
    group  => 'pe-puppet',
    mode   => '0444',
    source => 'puppet:///modules/addcertwhitelist/ca.conf.erb',
    notify => Exec['restart-puppetserver'],
  }

  exec {'restart-puppetserver':
    path        => '/sbin',
    command     => 'service pe-puppetserver restart',
    refreshonly => true,
  }
}


