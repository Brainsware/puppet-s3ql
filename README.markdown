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

This is a puppet module to manage [s3ql](http://www.rath.org/s3ql-docs/about.html) installation, configuration and mounts.


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

Put the classes, types, and resources for customizing, configuring, and doing the fancy stuff with your module here. 

## Reference

Here, list the classes, types, providers, facts, etc contained in your module. This section should include all of the under-the-hood workings of your module so people know what the module is touching on their system but don't need to mess with things. (We are working on automating this section!)

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

Since your module is awesome, other users will want to play with it. Let them know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You may also add any additional sections you feel are necessary or important to include here. Please use the `## ` header. 
