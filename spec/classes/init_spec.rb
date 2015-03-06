require 'spec_helper'
describe 'addcertwhitelist' do

  context 'with defaults for all parameters' do
    it { should contain_class('addcertwhitelist') }
  end
end
