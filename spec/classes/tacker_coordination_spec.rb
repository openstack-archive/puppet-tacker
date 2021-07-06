require 'spec_helper'

describe 'tacker::coordination' do
  shared_examples 'tacker::coordination' do
    context 'with default parameters' do
      it {
        is_expected.to contain_oslo__coordination('tacker_config').with(
          :backend_url => '<SERVICE DEFAULT>'
        )
      }
    end

    context 'with specified parameters' do
      let :params do
        {
          :backend_url => 'etcd3+http://127.0.0.1:2379',
        }
      end

      it {
        is_expected.to contain_oslo__coordination('tacker_config').with(
          :backend_url => 'etcd3+http://127.0.0.1:2379'
        )
      }
    end
  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge(OSDefaults.get_facts())
      end

      it_behaves_like 'tacker::coordination'
    end
  end
end
