require 'spec_helper'
describe 'gruntcli' do
  context 'with default values for all parameters' do
    it { should contain_class('gruntcli') }
  end
end
