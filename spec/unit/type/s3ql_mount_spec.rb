require 'spec_helper'

type_class = Puppet::Type.type(:s3ql_mount)

describe type_class do
  let :params do
    [
      :mountpoint,
    ]
  end

  let :properties do
    [
      :storage_url,
      :backend_login,
      :backend_password,
      :fs_passphrase,
      :backend_options,
      :owner,
      :group,
      :backend,
    ]
  end
  let :parameters do
    [
      :mountpoint,
      :home,
      :force,
      :upload_interval,
    ]
  end

  it 'has expected properties' do
    properties.each do |property|
      expect(type_class.properties.map(&:name)).to be_include(property)
    end
  end
  it 'has expected parameters' do
    parameters.each do |param|
      expect(type_class.parameters.map).to be_include(param)
    end
    # XXX: what in the world is the distinction between parameters and params??
    params.each do |param|
      expect(type_class.parameters).to be_include(param)
    end
  end

  it 'requires a name' do
    expect {
      type_class.new({})
    }.to raise_error(Puppet::Error, 'Title or name must be provided')
  end

  context 'when passing an UID or GID to owner/group it should be normalized to an Integer' do
    let(:mnt) { type_class.new(mountpoint: '/mnt', owner: '1023', group: 1024) }

    it 'converts uid & gid values to an (unchanged) integer' do
      expect(mnt[:owner].is_a?(Integer)).to be true
      expect(mnt[:owner]).to be 1023

      expect(mnt[:group].is_a?(Integer)).to be true
      expect(mnt[:group]).to be 1024
    end
  end

  context 'when passing an username or groupname  to owner/group it should be normalized to an Integer' do
    let(:mnt) { type_class.new(mountpoint: '/mnt', owner: 'examplewww', group: 'examplewww') }

    it 'converts uid & gid values to an (unchanged) integer' do
      Etc.stubs(:getpwnam).with('examplewww').returns(uid: 33)
      Etc.stubs(:getgrnam).with('examplewww').returns(gid: 33)

      expect(mnt[:owner].is_a?(Integer)).to be true
      expect(mnt[:owner]).to be 33

      expect(mnt[:group].is_a?(Integer)).to be true
      expect(mnt[:group]).to be 33
    end
  end
end
