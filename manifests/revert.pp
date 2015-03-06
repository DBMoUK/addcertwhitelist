class certwhitelist::revert
{
  include certwhitelist
  include certwhitelist::restart

  $templatepath             = $certwhitelist::templatepath 
  $console_client_certname  = $certwhitelist::console_client_certname 

  file { "${templatepath}/ca.conf.erb":
    ensure  => file,
    owner   => 'pe-puppet',
    group   => 'pe-puppet',
    mode    => '444',
    content => template('certwhitelist/ca.conf.original.erb'),
    notify  => Class['certwhitelist::restart'],
  }

}
