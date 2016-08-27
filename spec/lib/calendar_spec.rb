require 'spec_helper'
require 'calendar'

describe Calendar do
  it 'understands the seasons' do
    allow(described_class.date).to receive(:month).and_return(1)
    expect(described_class.season).to eq('winter')

    allow(described_class.date).to receive(:month).and_return(4)
    expect(described_class.season).to eq('spring')

    allow(described_class.date).to receive(:month).and_return(7)
    expect(described_class.season).to eq('summer')

    allow(described_class.date).to receive(:month).and_return(10)
    expect(described_class.season).to eq('fall')
  end
end
