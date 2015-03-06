class certwhitelist::add
{
  include certwhitelist
  include certwhitelist::restart


  $templatepath             = $certwhitelist::templatepath 
  $console_client_certname  = $certwhitelist::console_client_certname 

  file { "${templatepath}/ca.conf.erb":
    ensure => file,
    owner  => 'pe-puppet',
    group  => 'pe-puppet',
    mode   => '0444',
    content => template('certwhitelist/ca.conf.whitelist.erb'),
    notify => Class['certwhitelist::restart'],
  }
}


