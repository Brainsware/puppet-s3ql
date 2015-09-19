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

  package { $package_name:
    ensure   => $package_ensure,
    provider => $package_provider,
  }
}
