require 'spec_helper'

describe 's3ql::authinfo', :type => :define do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context 's3ql::authinfo for www-data & gs backend' do
          let(:title) { 'everything is gonna be alright' }
          let(:params) do
            {
              :backend          => 'gs',
              :backend_login    => 'oauth2',
              :backend_password => 'a very long, unique looking oauth2 token',
              :storage_url      => 'gs://bucket/prefix',
              :fs_passphrase    => 'v very secure passphrase for filesystem encryption',
              :owner            => 'www-data',
              :group            => 'www-data',
              :home             => '/var/www/.s3ql',
            }
          end

          # require 'pry'; binding.pry
          it { is_expected.to compile.with_all_deps }

          it do
            is_expected.to contain_file('/var/www/.s3ql/authinfo2')
              .with_ensure('present')
              .with_owner('www-data')
              .with_group('www-data')
              .with_mode('0400')
            # now, wouldn't it bee amaaazing if you could just test the
            # contents here, rather than the specific implementation?
          end
        end

        context "s3ql::authinfo with wrong `home' parameter" do
          let(:title) { 'wrong home' }
          let(:params) do
            {
              :owner            => 'www-data',
              :home             => '~/.s3ql',
              :backend          => 'gs',
              :backend_login    => 'oauth2',
              :backend_password => 'a very long, unique looking oauth2 token',
              :storage_url      => 'gs://bucket/prefix',
              :fs_passphrase    => 'v very secure passphrase for filesystem encryption',
            }
          end

          it { is_expected.to raise_error(Puppet::Error, /is not an absolute path/) }
        end
      end
    end
  end
end
