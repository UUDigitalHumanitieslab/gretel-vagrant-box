require 'spec_helper'
describe 'alpino' do
  context 'with default values for all parameters' do
    it { should contain_class('alpino') }
  end
end
