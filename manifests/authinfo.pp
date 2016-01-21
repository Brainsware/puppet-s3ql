# Define s3ql::authinfo
# =====================
#
# This defined type creates ~/.s3ql/authinfo2 files
# It's basically just a very thin wrapper around ini_setting :)
#
define s3ql::authinfo (
  $owner,
  $home,
  $backend,
  $storage_url,
  $backend_login,
  $backend_password,
  $fs_passphrase,
  $ensure      = 'present',
  $group       = undef,
  $manage_home = false,
) {

  validate_re($ensure, '^(present|absent)$')
  validate_absolute_path($home)
  $path = "${home}/authinfo2"

  $_group = $group ? {
    undef   => $owner,
    default => $group,
  }

  if $manage_home {
    file { $home:
      ensure  => directory,
      owner   => $owner,
      group   => $_group,
      mode    => '0750',
      before  => File[$path],
    }
  }

  file { $path:
    ensure => $ensure,
    owner  => $owner,
    group  => $_group,
    mode   => '0400',
  }

  Ini_setting {
    ensure  => $ensure,
    path    => $path,
    section => $backend,
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
