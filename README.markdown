[![Puppet Forge](https://img.shields.io/puppetforge/v/brainsware/s3ql.svg)](https://forge.puppetlabs.com/brainsware/s3ql) 
[![Build Status](https://img.shields.io/travis/Brainsware/puppet-s3ql/master.svg)](https://travis-ci.org/Brainsware/puppet-s3ql) 

#### Table of Contents

1. [Overview](#overview)
3. [Setup - The basics of getting started with s3ql](#setup)
    * [What s3ql affects](#what-s3ql-affects)
    * [Beginning with s3ql](#beginning-with-s3ql)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This is a puppet module to manage
[s3ql](http://www.rath.org/s3ql-docs/about.html) installation, authentication
configuration and mounts.


## Setup

### What s3ql affects

* This module will install 2.x version of s3ql from upstream repositories if you so chose
* It will run a python daemon as the owning user per filesystem mount
* That daemon will ***connect to the cloud***

### Beginning with s3ql

puppet-s3ql cannot help you setup an S3 or Google Storage account, or take the
[prerequisite steps](http://www.rath.org/s3ql-docs/backends.html) to be able to
use them as backends.

This first iteration will not support an [initial
formatting](http://www.rath.org/s3ql-docs/mkfs.html) so you'll have to do that,
too. It does support creating [authinfo files](http://www.rath.org/s3ql-docs/authinfo.html) though.

## Usage

First, let's install it:

```puppet
# only on Ubuntu:
# apt::ppa { 'ppa:nikratio/s3ql': }
# everywhere:
include s3ql
```

Next, we can setup our authentication:

```puppet
s3ql::authinfo { 'gs backend for www-data fluffy bucket':
  backend          => 'gs',
  storage_url      => 'gs://fluffy/example',
  backend_login    => 'oauth2',
  backend_password => 'actually a very long and secure oauth token',
  fs_passphrase    => 'also a very long and very secure passphrase for encrypting this filesystem',
}
```

And finally, we can mount it:

```puppet
s3ql_mount { '/srv/web/example/htdocs/uploads':
  ensure      => 'present',
  owner       => 'www-data',
  group       => 'www-data',
  storage_url => 'gs://fluffy/example',
}
```

## Reference

### s3ql

This class is only responsible for installing the s3ql package

#### s3ql::package_name

Name of the s3ql package. Default: `s3ql`

#### s3ql::package_ensure

Whether to install or remove, or keep the s3ql package in specific version. Default: `present`

#### s3ql::package_provider

Maybe some day s3ql will be easily installable via `pip` then you can override this parameter. Default: `undef`

### s3ql::authinfo

This defined type creates `~/.s3ql/authinfo2` files, storing credentials to the
various backends. It's basically just a very thin wrapper around
[ini_setting](https://github.com/puppetlabs/puppetlabs-inifile) :)

#### s3ql::authinfo::ensure

Whether to add or remove this entry. Default: `present`

#### s3ql::authinfo::owner
#### s3ql::authinfo::group
#### s3ql::authinfo::home

Owner, group and HOME have to be set. HOME should point to the fully-qualified path of ~/.s3ql.

#### s3ql::authinfo::manage_home

Whether to create the user's .s3ql home directory. Default: `false`

#### s3ql::authinfo::backend

Which backend to configure. Can be `gs`, `s3`, etc...

#### s3ql::authinfo::storage_url

The storage-url for which these credentials are valid.

#### s3ql::authinfo::backend_login
#### s3ql::authinfo::backend_password

The login and password. For `gs` there's a special `backend-login` `oauth2`
which activates OAuth authentication.

#### s3ql::authinfo::fs_passphrase

The passphrase with which this filesystem is encrypted.

### s3ql_mount

`s3ql_mount` creates mount.s3ql mounts. It can be used with `puppet resource`.

#### s3ql_mount::mountpoint

The path to the mountpoint. Default: `name`

#### s3ql_mount::storage_url

The storage-url to mount

#### s3ql_mount::backend_login

The backend-login for the specified storage-url.
If ommited, it will be read from authfile.

#### s3ql_mount::backend_password

The backend-login for the specified storage-url.
If ommited, it will be read from authfile.

#### s3ql_mount::fs_passphrase

The fs-passphrase for the specified storage-url.
If ommited, it will be read from authfile.

#### s3ql_mount::backend_options

Additional options passed to mount.s3ql when mounting this filesystem.

#### s3ql_mount::owner

The owner this filesytem will belong to. (normalized to uid)

#### s3ql_mount::group

The group this filesytem will belong to. (normalized to gid)

#### s3ql_mount::home

The fully-qualified path to the ~/.s3ql home dir

This directory will be used cache directory, and as base for the authinfo2
searchpath.

This parameter is not entirely discoverable. It will default to `$HOME/.s3ql`,
but this might be wrong for users who have no `$HOME`, for instance.

#### s3ql_mount::backend

The backend used. This property is read-only.


## Limitations

Given the rather clumsy installation on RHEL (or rather: the lack of package
repositories), this module will currently only work properly on:

- Archlinux
- Debian
- FreeBSD
- Gentoo
- OS X
- Ubuntu

## Development

If you find a way to install this module painfree under RHEL, I would very
happily accept your patch! Please follow our guidlines in CONTRIBUTING.md.
