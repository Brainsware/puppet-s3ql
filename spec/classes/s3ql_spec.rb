require 'spec_helper'

describe 's3ql' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "s3ql class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_package('s3ql').with_ensure('present') }
        end
      end
    end
  end

end
