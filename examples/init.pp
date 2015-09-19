# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation
# errors and view a log of events) or by fully applying the test in a virtual
# environment (to compare the resulting system state to the desired state).
#
# Learn more about module testing here:
# http://docs.puppetlabs.com/guides/tests_smoke.html
#

# First, let's install it:
# only on Ubuntu:
# apt::ppa { 'ppa:nikratio/s3ql': }
# everywhere:
include s3ql

# Next, we can setup our authentication:

s3ql::authinfo { 'gs backend for www-data fluffy bucket':
  backend          => 'gs',
  storage_url      => 'gs://fluffy/example',
  backend_login    => 'oauth2',
  backend_password => 'actually a very long and secure oauth token',
  fs_passphrase    => 'also a very long and very secure passphrase for encrypting this filesystem',
}

# And finally, we can mount it:

s3ql_mount { '/srv/web/example/htdocs/uploads':
  ensure      => 'present',
  owner       => 'www-data',
  group       => 'www-data',
  storage_url => 'gs://fluffy/example',
}
