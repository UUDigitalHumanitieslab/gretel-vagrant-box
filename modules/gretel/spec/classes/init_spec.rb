require 'spec_helper'
describe 'gretel' do
  context 'with default values for all parameters' do
    it { should contain_class('gretel') }
  end
end
