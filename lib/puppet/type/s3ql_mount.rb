#   Copyright 2016 Brainsware
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

Puppet::Type.newtype(:s3ql_mount) do
  desc 's3ql_mount is a type to create mount.s3ql mounts'

  ensurable

  newparam(:mountpoint, :namevar => true) do
    desc 'The path to the mountpoint'
    newvalues(%r{^/})
  end

  newproperty(:storage_url) do
    desc 'The storage-url to mount'
  end

  newproperty(:backend_login) do
    desc <<-EOS
      The backend-login for the specified storage-url.

      If ommited, it will be read from authfile.
    EOS
  end

  newproperty(:backend_password) do
    desc <<-EOS
      The backend-login for the specified storage-url.

      If ommited, it will be read from authfile.
    EOS
  end

  newproperty(:fs_passphrase) do
    desc <<-EOS
      The fs-passphrase for the specified storage-url.

      If ommited, it will be read from authfile.
    EOS
  end

  # this one is not /really/ discoverable.
  # hence a it is a parameter, not a property of the system
  newparam(:home) do
    desc <<-EOS
      The fully-qualified path to the ~/.s3ql home dir

      This directory will be used cache directory, and as base for the
      authinfo2 searchpath.
    EOS
  end

  newproperty(:backend_options) do
    desc 'Additional options passed to mount.s3ql when mounting this filesystem.'
  end

  newproperty(:owner) do
    desc 'The owner this filesytem will belong to. (normalized to uid)'
    defaultto 0
    munge do |val|
      begin
        Integer(val)
      rescue
        require 'etc'
        Etc.getpwnam(val)[:uid]
      end
    end
  end

  newproperty(:group) do
    desc 'The group this filesytem will belong to. (normalized to gid)'
    defaultto 0
    munge do |val|
      begin
        Integer(val)
      rescue
        require 'etc'
        Etc.getgrnam(val)[:gid]
      end
    end
  end

  newproperty(:backend) do
    desc <<-EOS
      The backend used.

      This property is read-only.
    EOS
  end

  autorequire(:package) do
    's3ql'
  end
end
