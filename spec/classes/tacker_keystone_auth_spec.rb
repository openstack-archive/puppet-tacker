#
# Unit tests for tacker::keystone::auth
#

require 'spec_helper'

describe 'tacker::keystone::auth' do
  shared_examples_for 'tacker-keystone-auth' do
    context 'with default class parameters' do
      let :params do
        { :password => 'tacker_password',
          :tenant   => 'foobar' }
      end

      it { is_expected.to contain_keystone_user('tacker').with(
        :ensure   => 'present',
        :password => 'tacker_password',
      ) }

      it { is_expected.to contain_keystone_user_role('tacker@foobar').with(
        :ensure  => 'present',
        :roles   => ['admin']
      )}

      it { is_expected.to contain_keystone_service('tacker::nfv-orchestration').with(
        :ensure      => 'present',
        :description => 'tacker NFV orchestration Service'
      ) }

      it { is_expected.to contain_keystone_endpoint('RegionOne/tacker::nfv-orchestration').with(
        :ensure       => 'present',
        :public_url   => 'http://127.0.0.1:9890',
        :admin_url    => 'http://127.0.0.1:9890',
        :internal_url => 'http://127.0.0.1:9890',
      ) }
    end

    context 'when overriding URL parameters' do
      let :params do
        { :password     => 'tacker_password',
          :public_url   => 'https://10.10.10.10:80',
          :internal_url => 'http://10.10.10.11:81',
          :admin_url    => 'http://10.10.10.12:81', }
      end

      it { is_expected.to contain_keystone_endpoint('RegionOne/tacker::nfv-orchestration').with(
        :ensure       => 'present',
        :public_url   => 'https://10.10.10.10:80',
        :internal_url => 'http://10.10.10.11:81',
        :admin_url    => 'http://10.10.10.12:81',
      ) }
    end

    context 'when overriding auth name' do
      let :params do
        { :password => 'foo',
          :auth_name => 'tackery' }
      end

      it { is_expected.to contain_keystone_user('tackery') }
      it { is_expected.to contain_keystone_user_role('tackery@services') }
      it { is_expected.to contain_keystone_service('tacker::nfv-orchestration') }
      it { is_expected.to contain_keystone_endpoint('RegionOne/tacker::nfv-orchestration') }
    end

    context 'when overriding service name' do
      let :params do
        { :service_name => 'tacker_service',
          :auth_name    => 'tacker',
          :password     => 'tacker_password' }
      end

      it { is_expected.to contain_keystone_user('tacker') }
      it { is_expected.to contain_keystone_user_role('tacker@services') }
      it { is_expected.to contain_keystone_service('tacker_service::nfv-orchestration') }
      it { is_expected.to contain_keystone_endpoint('RegionOne/tacker_service::nfv-orchestration') }
    end

    context 'when disabling user configuration' do

      let :params do
        {
          :password       => 'tacker_password',
          :configure_user => false
        }
      end

      it { is_expected.not_to contain_keystone_user('tacker') }
      it { is_expected.to contain_keystone_user_role('tacker@services') }
      it { is_expected.to contain_keystone_service('tacker::nfv-orchestration').with(
        :ensure      => 'present',
        :description => 'tacker NFV orchestration Service'
      ) }

    end

    context 'when disabling user and user role configuration' do

      let :params do
        {
          :password            => 'tacker_password',
          :configure_user      => false,
          :configure_user_role => false
        }
      end

      it { is_expected.not_to contain_keystone_user('tacker') }
      it { is_expected.not_to contain_keystone_user_role('tacker@services') }
      it { is_expected.to contain_keystone_service('tacker::nfv-orchestration').with(
        :ensure      => 'present',
        :description => 'tacker NFV orchestration Service'
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

      it_behaves_like 'tacker-keystone-auth'
    end
  end
end
