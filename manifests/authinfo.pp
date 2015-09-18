# Define s3ql::authinfo
# =====================
#
# This defined type creates ~/.s3ql/authinfo2 files
# It's basically just a very thin wrapper around ini_setting :)
#
define s3ql::authinfo (
  $ensure  = 'present',
  $owner   = undef,
  $group   = undef,
  $home    = undef,
  $backend = undef,
  $storage_url      = undef,
  $backend_login    = undef,
  $backend_password = undef,
  $fs_passphrase    = undef,
) {

  $path = "${home}/authinfo2"

  file { $path:
    ensure => $ensure,
    owner  => $owner,
    group  => $group,
    mode   => '0400',
  }

  Ini_setting {
    ensure  => $ensure,
    path    => $path,
    section => $backend,
    require => File[$path],
  }

  ini_setting {
    "authinfo2 storage-url settings for ${owner}'s ${backend} backend":
      setting => 'storage-url',
      value   => $storage_url;

    "authinfo2 backend-login settings for ${owner}'s ${backend} backend":
      setting => 'backend-login',
      value   => $backend_login;

    "authinfo2 backend-password settings for ${owner}'s ${backend} backend":
      setting => 'backend-password',
      value   => $backend_password;

    "authinfo2 fs-passphrase settings for ${owner}'s ${backend} backend":
      setting => 'fs-passphrase',
      value   => $fs_passphrase;
  }
}
