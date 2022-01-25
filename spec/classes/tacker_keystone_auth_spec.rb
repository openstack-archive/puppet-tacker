#
# Unit tests for tacker::keystone::auth
#

require 'spec_helper'

describe 'tacker::keystone::auth' do
  shared_examples_for 'tacker::keystone::auth' do
    context 'with default class parameters' do
      let :params do
        { :password => 'tacker_password' }
      end

      it { is_expected.to contain_keystone__resource__service_identity('tacker').with(
        :configure_user      => true,
        :configure_user_role => true,
        :configure_endpoint  => true,
        :service_name        => 'tacker',
        :service_type        => 'nfv-orchestration',
        :service_description => 'tacker NFV orchestration Service',
        :region              => 'RegionOne',
        :auth_name           => 'tacker',
        :password            => 'tacker_password',
        :email               => 'tacker@localhost',
        :tenant              => 'services',
        :roles               => ['admin'],
        :system_scope        => 'all',
        :system_roles        => [],
        :public_url          => 'http://127.0.0.1:9890',
        :internal_url        => 'http://127.0.0.1:9890',
        :admin_url           => 'http://127.0.0.1:9890',
      ) }
    end

    context 'when overriding parameters' do
      let :params do
        { :password            => 'tacker_password',
          :auth_name           => 'alt_tacker',
          :email               => 'alt_tacker@alt_localhost',
          :tenant              => 'alt_service',
          :roles               => ['admin', 'service'],
          :system_scope        => 'alt_all',
          :system_roles        => ['admin', 'member', 'reader'],
          :configure_endpoint  => false,
          :configure_user      => false,
          :configure_user_role => false,
          :service_description => 'Alternative tacker NFV orchestration Service',
          :service_name        => 'alt_service',
          :service_type        => 'alt_nfv-orchestration',
          :region              => 'RegionTwo',
          :public_url          => 'https://10.10.10.10:80',
          :internal_url        => 'http://10.10.10.11:81',
          :admin_url           => 'http://10.10.10.12:81' }
      end

      it { is_expected.to contain_keystone__resource__service_identity('tacker').with(
        :configure_user      => false,
        :configure_user_role => false,
        :configure_endpoint  => false,
        :service_name        => 'alt_service',
        :service_type        => 'alt_nfv-orchestration',
        :service_description => 'Alternative tacker NFV orchestration Service',
        :region              => 'RegionTwo',
        :auth_name           => 'alt_tacker',
        :password            => 'tacker_password',
        :email               => 'alt_tacker@alt_localhost',
        :tenant              => 'alt_service',
        :roles               => ['admin', 'service'],
        :system_scope        => 'alt_all',
        :system_roles        => ['admin', 'member', 'reader'],
        :public_url          => 'https://10.10.10.10:80',
        :internal_url        => 'http://10.10.10.11:81',
        :admin_url           => 'http://10.10.10.12:81',
      ) }
    end
  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      it_behaves_like 'tacker::keystone::auth'
    end
  end
end
