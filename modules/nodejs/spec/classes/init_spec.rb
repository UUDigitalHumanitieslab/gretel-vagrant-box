require 'spec_helper'
describe 'nodejs' do
  context 'with default values for all parameters' do
    it { should contain_class('nodejs') }
  end
end
