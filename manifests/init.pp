# Class: s3ql
# ===========
#
# This class installs the latest stable version of s3ql
#
class s3ql (
  $package_name     = 's3ql',
  $package_ensure   = 'present',
  $package_provider = undef,
) {

  package { 's3ql':
    ensure   => $package_ensure,
    name     => $package_name,
    provider => $package_provider,
  }
}
