Puppet::Type.type(:tacker_config).provide(
  :openstackconfig,
  :parent => Puppet::Type.type(:openstack_config).provider(:ruby)
) do

  def self.file_path
    '/etc/tacker/tacker.conf'
  end

end
