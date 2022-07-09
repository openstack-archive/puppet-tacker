Puppet::Type.type(:tacker_api_paste_ini).provide(
  :ini_setting,
  :parent => Puppet::Type.type(:openstack_config).provider(:ini_setting)
) do

  def self.file_path
    '/etc/tacker/api-paste.ini'
  end

end
