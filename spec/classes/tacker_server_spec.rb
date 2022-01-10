require 'spec_helper'

describe 'tacker::server' do

  let :pre_condition do
    "class { 'tacker::keystone::authtoken':
       password =>'foo',
     }
     class {'tacker': }"
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
      is_expected.to contain_tacker_config('DEFAULT/api_workers').with_value(4)
    end

    [{:enabled => true}, {:enabled => false}].each do |param_hash|
      context "when service should be #{param_hash[:enabled] ? 'enabled' : 'disabled'}" do
        before do
          params.merge!(param_hash)
        end

        it 'configures tacker-server service' do
          is_expected.to contain_service('tacker-server').with(
            :ensure => (params[:manage_service] && params[:enabled]) ? 'running' : 'stopped',
            :name   => platform_params[:server_service_name],
            :enable => params[:enabled],
            :tag    => 'tacker-service',
          )
        end
        it 'contains tacker' do
          is_expected.to contain_package('tacker-server').with(
             :ensure => 'installed',
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
        facts.merge!(OSDefaults.get_facts(
          :os_workers => 4
        ))
      end

      let(:platform_params) do
        case facts[:osfamily]
        when 'Debian'
          { :server_service_name => 'tacker',
            :tacker_package      => 'tacker' }
        when 'RedHat'
          { :server_service_name => 'openstack-tacker-server',
            :tacker_package      => 'openstack-tacker' }
        end
      end

      it_configures 'tacker::server'
    end
  end
end
