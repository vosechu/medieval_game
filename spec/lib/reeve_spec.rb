require 'spec_helper'
require 'reeve'

describe Reeve do
  let(:village) { instance_double("Village") }
  subject { described_class.new(village: village) }

  it 'exercises' do
    subject.work_groups
  end
end
