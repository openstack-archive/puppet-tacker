require 'spec_helper'

describe 'tacker::conductor' do

  let :pre_condition do
    "class {'tacker': }"
  end

  let :params do
    { :enabled        => true,
      :manage_service => true,
    }
  end

  shared_examples_for 'tacker::conductor' do

    it { is_expected.to contain_class('tacker::deps') }
    it { is_expected.to contain_class('tacker::params') }

    it {
      is_expected.to contain_tacker_config('DEFAULT/report_interval').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_tacker_config('DEFAULT/periodic_interval').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_tacker_config('DEFAULT/periodic_fuzzy_delay').with_value('<SERVICE DEFAULT>')
    }

    [{:enabled => true}, {:enabled => false}].each do |param_hash|
      context "when service should be #{param_hash[:enabled] ? 'enabled' : 'disabled'}" do
        before do
          params.merge!(param_hash)
        end

        it 'configures tacker-server service' do
          is_expected.to contain_service('tacker-conductor').with(
            :ensure => (params[:manage_service] && params[:enabled]) ? 'running' : 'stopped',
            :name   => platform_params[:conductor_service_name],
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

    context 'when parameters set' do
      before do
        params.merge!(
          :report_interval      => 10,
          :periodic_interval    => 40,
          :periodic_fuzzy_delay => 5,
        )
      end
      it {
        is_expected.to contain_tacker_config('DEFAULT/report_interval').with_value(10)
        is_expected.to contain_tacker_config('DEFAULT/periodic_interval').with_value(40)
        is_expected.to contain_tacker_config('DEFAULT/periodic_fuzzy_delay').with_value(5)
      }
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
          { :conductor_service_name => 'tacker-conductor',
            :tacker_package         => 'tacker' }
        when 'RedHat'
          { :conductor_service_name => 'openstack-tacker-conductor',
            :tacker_package         => 'openstack-tacker' }
        end
      end

      it_configures 'tacker::conductor'
    end
  end
end
