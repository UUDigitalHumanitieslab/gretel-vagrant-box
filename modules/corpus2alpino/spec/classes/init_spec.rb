require 'spec_helper'
describe 'corpus2alpino' do
  context 'with default values for all parameters' do
    it { should contain_class('corpus2alpino') }
  end
end
