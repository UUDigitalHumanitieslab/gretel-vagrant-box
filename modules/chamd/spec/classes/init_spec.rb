require 'spec_helper'
describe 'chamd' do
  context 'with default values for all parameters' do
    it { should contain_class('chamd') }
  end
end
