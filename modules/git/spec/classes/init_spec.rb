require 'spec_helper'
describe 'git' do
  context 'with default values for all parameters' do
    it { should contain_class('git') }
  end
end
