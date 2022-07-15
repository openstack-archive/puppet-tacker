require 'spec_helper_acceptance'

describe 'basic tacker' do

  context 'default parameters' do

    it 'should work with no errors' do
      pp= <<-EOS
      include openstack_integration
      include openstack_integration::repos
      include openstack_integration::apache
      include openstack_integration::rabbitmq
      include openstack_integration::mysql
      include openstack_integration::keystone

      rabbitmq_user { 'tacker':
        admin    => true,
        password => 'my_secret',
        provider => 'rabbitmqctl',
        require  => Class['rabbitmq'],
      }

      rabbitmq_user_permissions { 'tacker@/':
        configure_permission => '.*',
        write_permission     => '.*',
        read_permission      => '.*',
        provider             => 'rabbitmqctl',
        require              => Class['rabbitmq'],
      }

      class { 'tacker::db::mysql':
        charset  => $::openstack_integration::params::mysql_charset,
        password => 'a_big_secret',
      }
      case $::osfamily {
        'Debian': {
          warning('Tacker is not yet packaged on Ubuntu systems.')
        }
        'RedHat': {
          class { 'tacker::db':
            database_connection => 'mysql+pymysql://tacker:a_big_secret@127.0.0.1/tacker?charset=utf8',
          }
          class { 'tacker::keystone::auth':
            password => 'a_big_secret',
          }
          class { 'tacker::keystone::authtoken':
            password => 'a_big_secret',
          }
          class { 'tacker::logging':
            debug => true,
          }
          class { 'tacker':
            default_transport_url => 'rabbit://tacker:my_secret@127.0.0.1:5672/',
          }
          include tacker::server
          include tacker::client
        }
        default: {
          fail("Unsupported osfamily (${::osfamily})")
        }
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    if os[:family].casecmp('RedHat') == 0
      describe port(9890) do
        it { is_expected.to be_listening }
      end
    end
  end

end
