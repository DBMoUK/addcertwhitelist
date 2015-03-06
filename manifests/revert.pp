class certwhitelist::revert {

include certwhitelist::restart

  $templatepath = '/opt/puppet/share/puppet/modules/puppet_enterprise/templates/master/puppetserver'

  file { "${templatepath}/ca.conf.erb":
    ensure => file,
    source => 'puppet:///modules/certwhitelist/ca.conf.original.erb',
    owner  => 'pe-puppet',
    group  => 'pe-puppet',
    mode   => '444',
    notify => Certwhitelist::Restart::Exec['restart-puppetserver'],
  }

}
