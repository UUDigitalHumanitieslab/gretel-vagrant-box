require 'spec_helper'
describe 'gretelupload' do
  context 'with default values for all parameters' do
    it { should contain_class('gretelupload') }
  end
end
