require 'spec_helper'
describe 'puppetserver_whitelist' do

  context 'with defaults for all parameters' do
    it { should contain_class('puppetserver_whitelist') }
  end
end
