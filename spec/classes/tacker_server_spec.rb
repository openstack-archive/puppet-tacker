require 'spec_helper'

describe 'tacker::server' do

  let :pre_condition do
    "class { '::tacker::keystone::authtoken':
       password =>'foo',
     }
     class {'::tacker': }"
  end

  let :params do
    { :enabled        => true,
      :manage_service => true,
      :bind_host      => '0.0.0.0',
      :bind_port      => '1789'
    }
  end

  shared_examples_for 'tacker::server' do

    it { is_expected.to contain_class('tacker::deps') }
    it { is_expected.to contain_class('tacker::params') }
    it { is_expected.to contain_class('tacker::policy') }

    it 'configures api' do
      is_expected.to contain_tacker_config('DEFAULT/bind_host').with_value( params[:bind_host] )
      is_expected.to contain_tacker_config('DEFAULT/bind_port').with_value( params[:bind_port] )
    end

    [{:enabled => true}, {:enabled => false}].each do |param_hash|
      context "when service should be #{param_hash[:enabled] ? 'enabled' : 'disabled'}" do
        before do
          params.merge!(param_hash)
        end

        it 'configures tacker-server service' do
          is_expected.to contain_service('tacker-server').with(
            :ensure => (params[:manage_service] && params[:enabled]) ? 'running' : 'stopped',
            :name   => platform_params[:tacker_service],
            :enable => params[:enabled],
            :tag    => 'tacker-service',
          )
        end
        it 'contains tacker' do
          is_expected.to contain_package('tacker-server').with(
             :ensure => 'present',
             :name   => platform_params[:tacker_package]
          )
        end

      end
    end

  end

  on_supported_os({
    :supported_os   => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      let(:platform_params) do
        case facts[:osfamily]
        when 'Debian'
          { :tacker_service => 'tacker',
            :tacker_package => 'tacker' }
        when 'RedHat'
          { :tacker_service => 'openstack-tacker-server',
            :tacker_package => 'openstack-tacker' }
        end
      end

      it_configures 'tacker::server'
    end
  end
end
