require 'spec_helper'

type_class     = Puppet::Type.type(:s3ql_mount)
provider_class = type_class.provide(:s3ql_mount)

describe provider_class do
  context 'with the minimum parameters' do
    let(:resource) do
      type_class.new(
        mountpoint: '/mnt',
        storage_url: 'gs://bucket/prefix',
        owner: 'examplewww',
        group: 'examplewww',
        allow_other: true,
      )
    end

    let(:provider) { resource.provider }
    let(:instance) { provider.class.instance.first }

    it 'is an instance of the S3ql_mount' do
      expect(provider).to be_an_instance_of Puppet::Type::S3ql_mount::S3ql_mount
    end
  end
end
