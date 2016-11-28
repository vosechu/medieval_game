require 'spec_helper'
require 'field'

describe Field do
  subject { described_class.new(acres: 10) }
  it 'does something' do
    subject
  end

  describe '#reserve' do
    it 'can be reserved' do
      subject.instance_variable_set(:@reserved, false)
      expect { subject.reserve }.to change { subject.reserved? }.from(false).to(true)
    end
  end
end
