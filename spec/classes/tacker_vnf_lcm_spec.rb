require 'spec_helper'

describe 'tacker::vnf_lcm' do

  shared_examples_for 'tacker::vnf_lcm' do

    context 'with defaults' do
      it 'configures defaults' do
        is_expected.to contain_tacker_config('vnf_lcm/endpoint_url').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_tacker_config('vnf_lcm/subscription_num').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_tacker_config('vnf_lcm/retry_num').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_tacker_config('vnf_lcm/retry_wait').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_tacker_config('vnf_lcm/test_callback_uri').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with parameters set' do
      let :params do
        {
          :endpoint_url      => 'http://localhost:9890/',
          :subscription_num  => 100,
          :retry_num         => 3,
          :retry_wait        => 10,
          :test_callback_uri => true,
        }
      end

      it 'configures the specified values' do
        is_expected.to contain_tacker_config('vnf_lcm/endpoint_url').with_value('http://localhost:9890/')
        is_expected.to contain_tacker_config('vnf_lcm/subscription_num').with_value(100)
        is_expected.to contain_tacker_config('vnf_lcm/retry_num').with_value(3)
        is_expected.to contain_tacker_config('vnf_lcm/retry_wait').with_value(10)
        is_expected.to contain_tacker_config('vnf_lcm/test_callback_uri').with_value(true)
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

      it_configures 'tacker::vnf_lcm'
    end
  end
end
