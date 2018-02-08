require 'spec_helper'
describe 'folia2alpino' do
  context 'with default values for all parameters' do
    it { should contain_class('folia2alpino') }
  end
end
