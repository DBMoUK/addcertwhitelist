class certwhitelist::restart {

  exec { 'restart-puppetserver':
    path        => '/sbin',
    command     => 'service pe-puppet restart',
    refreshonly => true,
  }
}
