require 'spec_helper'

describe 'tacker::db::sync' do

  shared_examples_for 'tacker-dbsync' do

    it 'runs tacker-manage db sync' do
      is_expected.to contain_exec('tacker-db-sync').with(
        :command     => 'tacker-db-manage --config-file /etc/tacker/tacker.conf upgrade head',
        :user        => 'tacker',
        :path        => ['/bin','/usr/bin'],
        :refreshonly => 'true',
        :try_sleep   => 5,
        :tries       => 10,
        :logoutput   => 'on_failure',
        :subscribe   => ['Anchor[tacker::install::end]',
                         'Anchor[tacker::config::end]',
                         'Anchor[tacker::dbsync::begin]'],
        :notify      => 'Anchor[tacker::dbsync::end]',
        :tag         => 'openstack-db',
      )
    end

    describe "overriding extra_params" do
      let :params do
        {
          :extra_params => '--config-file /etc/tacker/tacker.conf',
        }
      end

      it {
        is_expected.to contain_exec('tacker-db-sync').with(
          :command     => 'tacker-db-manage --config-file /etc/tacker/tacker.conf upgrade head',
          :user        => 'tacker',
          :path        => ['/bin','/usr/bin'],
          :refreshonly => 'true',
          :try_sleep   => 5,
          :tries       => 10,
          :logoutput   => 'on_failure',
          :subscribe   => ['Anchor[tacker::install::end]',
                          'Anchor[tacker::config::end]',
                          'Anchor[tacker::dbsync::begin]'],
          :notify      => 'Anchor[tacker::dbsync::end]',
          :tag         => 'openstack-db',
        )
      }
    end

  end

  on_supported_os({
    :supported_os   => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge(OSDefaults.get_facts({
          :os_workers     => 8,
          :concat_basedir => '/var/lib/puppet/concat'
        }))
      end

      it_configures 'tacker-dbsync'
    end
  end

end
