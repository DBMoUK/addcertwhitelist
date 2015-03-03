class puppetserver_whitelist ( $cert_fqdn_names )
{
  $templatepath           = '/opt/puppet/share/puppet/modules/puppet_enterprise/templates/master/puppetserver'
  $puppetserver_file_path = '/etc/puppetlabs/puppetserver/conf.d'
  $dashboard_fqdn = 'pe-internal-dashboard'

  file { "${templatepath}/ca.conf.erb":
    ensure => file,
    owner  => 'pe-puppet',
    group  => 'pe-puppet',
    mode   => '0444',
    source => 'puppet:///modules/puppetserver_whitelist/ca.conf.erb',
    before => File["${puppetserver_file_path}/ca.conf"],
  }

  file { "${puppetserver_file_path}/ca.conf":
    ensure  => file,
    owner   => 'pe-puppet',
    group   => 'pe-puppet',
    mode    => '0640',
    content => template('puppetserver_whitelist/ca.conf.erb'),
    before  => Exec['restart-puppetserver'],
  }


  exec {'restart-puppetserver':
    path        => '/sbin',
    command     => 'service pe-puppetserver restart',
    refreshonly => true,
    subscribe   => File["${templatepath}/ca.conf.erb"],
  }
}


