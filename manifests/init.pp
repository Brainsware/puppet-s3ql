# Class: s3ql
# ===========
#
# This class installs the latest stable version of s3ql
#
class s3ql (
  $package_name     = 's3ql',
  $package_ensure   = 'present',
  $package_provider = undef,
  $allow_other = false,
) {

  package { 's3ql':
    ensure   => $package_ensure,
    name     => $package_name,
    provider => $package_provider,
  }

  if $allow_other {
    file_line { "user_allow_other ${allow_other}":
      path  => '/etc/fuse.conf',
      line  => 'user_allow_other',
      match => '^#user_allow_other'
    }
  }
}
