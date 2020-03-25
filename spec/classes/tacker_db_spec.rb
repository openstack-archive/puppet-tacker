require 'spec_helper'

describe 'tacker::db' do
  shared_examples 'tacker::db' do
    context 'with default parameters' do
      it { should contain_class('tacker::deps') }

      it { should contain_oslo__db('tacker_config').with(
        :db_max_retries          => '<SERVICE DEFAULT>',
        :connection              => 'sqlite:////var/lib/tacker/tacker.sqlite',
        :connection_recycle_time => '<SERVICE DEFAULT>',
        :max_pool_size           => '<SERVICE DEFAULT>',
        :max_retries             => '<SERVICE DEFAULT>',
        :retry_interval          => '<SERVICE DEFAULT>',
        :max_overflow            => '<SERVICE DEFAULT>',
        :pool_timeout            => '<SERVICE DEFAULT>',
      )}
    end

    context 'with specific parameters' do
      let :params do
        {
          :database_connection              => 'mysql+pymysql://tacker:tacker@localhost/tacker',
          :database_connection_recycle_time => '3601',
          :database_max_retries             => '11',
          :database_db_max_retries          => '-1',
          :database_retry_interval          => '11',
          :database_max_pool_size           => '11',
          :database_max_overflow            => '21',
          :database_pool_timeout            => '21',
        }
      end

      it { should contain_class('tacker::deps') }

      it { should contain_oslo__db('tacker_config').with(
        :connection              => 'mysql+pymysql://tacker:tacker@localhost/tacker',
        :connection_recycle_time => '3601',
        :max_pool_size           => '11',
        :max_retries             => '11',
        :db_max_retries          => '-1',
        :retry_interval          => '11',
        :max_overflow            => '21',
        :pool_timeout            => '21',
      )}
    end
  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      it_behaves_like 'tacker::db'
    end
  end
end
