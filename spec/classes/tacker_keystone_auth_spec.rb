#
# Unit tests for tacker::keystone::auth
#

require 'spec_helper'

describe 'tacker::keystone::auth' do

  let :facts do
    { :osfamily => 'Debian' }
  end

  describe 'with default class parameters' do
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

    it { is_expected.to contain_keystone_service('tacker').with(
      :ensure      => 'present',
      :type        => 'FIXME',
      :description => 'tacker FIXME Service'
    ) }

    it { is_expected.to contain_keystone_endpoint('RegionOne/tacker').with(
      :ensure       => 'present',
      :public_url   => 'http://127.0.0.1:FIXME',
      :admin_url    => 'http://127.0.0.1:FIXME',
      :internal_url => 'http://127.0.0.1:FIXME',
    ) }
  end

  describe 'when overriding URL paramaters' do
    let :params do
      { :password     => 'tacker_password',
        :public_url   => 'https://10.10.10.10:80',
        :internal_url => 'http://10.10.10.11:81',
        :admin_url    => 'http://10.10.10.12:81', }
    end

    it { is_expected.to contain_keystone_endpoint('RegionOne/tacker').with(
      :ensure       => 'present',
      :public_url   => 'https://10.10.10.10:80',
      :internal_url => 'http://10.10.10.11:81',
      :admin_url    => 'http://10.10.10.12:81',
    ) }
  end

  describe 'when overriding auth name' do
    let :params do
      { :password => 'foo',
        :auth_name => 'tackery' }
    end

    it { is_expected.to contain_keystone_user('tackery') }
    it { is_expected.to contain_keystone_user_role('tackery@services') }
    it { is_expected.to contain_keystone_service('tackery') }
    it { is_expected.to contain_keystone_endpoint('RegionOne/tackery') }
  end

  describe 'when overriding service name' do
    let :params do
      { :service_name => 'tacker_service',
        :auth_name    => 'tacker',
        :password     => 'tacker_password' }
    end

    it { is_expected.to contain_keystone_user('tacker') }
    it { is_expected.to contain_keystone_user_role('tacker@services') }
    it { is_expected.to contain_keystone_service('tacker_service') }
    it { is_expected.to contain_keystone_endpoint('RegionOne/tacker_service') }
  end

  describe 'when disabling user configuration' do

    let :params do
      {
        :password       => 'tacker_password',
        :configure_user => false
      }
    end

    it { is_expected.not_to contain_keystone_user('tacker') }
    it { is_expected.to contain_keystone_user_role('tacker@services') }
    it { is_expected.to contain_keystone_service('tacker').with(
      :ensure      => 'present',
      :type        => 'FIXME',
      :description => 'tacker FIXME Service'
    ) }

  end

  describe 'when disabling user and user role configuration' do

    let :params do
      {
        :password            => 'tacker_password',
        :configure_user      => false,
        :configure_user_role => false
      }
    end

    it { is_expected.not_to contain_keystone_user('tacker') }
    it { is_expected.not_to contain_keystone_user_role('tacker@services') }
    it { is_expected.to contain_keystone_service('tacker').with(
      :ensure      => 'present',
      :type        => 'FIXME',
      :description => 'tacker FIXME Service'
    ) }

  end

end
