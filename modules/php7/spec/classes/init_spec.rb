require 'spec_helper'
describe 'php7' do
  context 'with default values for all parameters' do
    it { should contain_class('php7') }
  end
end
