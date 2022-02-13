require 'puppet'
require 'puppet/type/tacker_api_paste_ini'

describe 'Puppet::Type.type(:tacker_api_paste_ini)' do
  before :each do
    @tacker_api_paste_ini = Puppet::Type.type(:tacker_api_paste_ini).new(:name => 'DEFAULT/foo', :value => 'bar')
  end

  it 'should accept a valid value' do
    @tacker_api_paste_ini[:value] = 'bar'
    expect(@tacker_api_paste_ini[:value]).to eq('bar')
  end

  it 'should autorequire the package that install the file' do
    catalog = Puppet::Resource::Catalog.new
    anchor = Puppet::Type.type(:anchor).new(:name => 'tacker::install::end')
    catalog.add_resource anchor, @tacker_api_paste_ini
    dependency = @tacker_api_paste_ini.autorequire
    expect(dependency.size).to eq(1)
    expect(dependency[0].target).to eq(@tacker_api_paste_ini)
    expect(dependency[0].source).to eq(anchor)
  end

end
