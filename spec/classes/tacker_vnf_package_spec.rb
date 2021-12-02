require 'spec_helper'

describe 'tacker::vnf_package' do

  shared_examples_for 'tacker::vnf_package' do

    context 'with defaults' do
      it 'configures defaults' do
        is_expected.to contain_tacker_config('vnf_package/vnf_package_csar_path').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_tacker_config('vnf_package/csar_file_size_cap').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_tacker_config('vnf_package/hashing_algorithm').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_tacker_config('vnf_package/get_top_list').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_tacker_config('vnf_package/exclude_node').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_tacker_config('vnf_package/get_lower_list').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_tacker_config('vnf_package/del_input_list').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with parameters set' do
      let :params do
        {
          :vnf_package_csar_path => '/var/lib/tacker/vnfpackages/',
          :csar_file_size_cap    => 1024,
          :hashing_algorithm     => 'sha512',
          :get_top_list          => ['tosca_definitions_version', 'description', 'metadata'],
          :exclude_node          => ['VNF'],
          :get_lower_list        => ['tosca.nodes.nfv.VNF', 'tosca.nodes.nfv.VDU.Tacker'],
          :del_input_list        => ['descriptor_id', 'descriptor_version'],
        }
      end

      it 'configures the specified values' do
        is_expected.to contain_tacker_config('vnf_package/vnf_package_csar_path').with_value('/var/lib/tacker/vnfpackages/')
        is_expected.to contain_tacker_config('vnf_package/csar_file_size_cap').with_value(1024)
        is_expected.to contain_tacker_config('vnf_package/hashing_algorithm').with_value('sha512')
        is_expected.to contain_tacker_config('vnf_package/get_top_list').with_value('tosca_definitions_version,description,metadata')
        is_expected.to contain_tacker_config('vnf_package/exclude_node').with_value('VNF')
        is_expected.to contain_tacker_config('vnf_package/get_lower_list').with_value('tosca.nodes.nfv.VNF,tosca.nodes.nfv.VDU.Tacker')
        is_expected.to contain_tacker_config('vnf_package/del_input_list').with_value('descriptor_id,descriptor_version')
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

      it_configures 'tacker::vnf_package'
    end
  end
end
