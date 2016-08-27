require 'spec_helper'
require 'calendar'

describe Calendar do
  after :each do
    Calendar.date = Date.new(800, 1, 1, Date::GREGORIAN)
  end

  it 'understands the seasons' do
    described_class.date = Date.new(800, 1, 1, Date::GREGORIAN)
    expect(described_class.send(:season)).to eq('winter')

    described_class.date = Date.new(800, 4, 1, Date::GREGORIAN)
    expect(described_class.send(:season)).to eq('spring')

    described_class.date = Date.new(800, 7, 1, Date::GREGORIAN)
    expect(described_class.send(:season)).to eq('summer')

    described_class.date = Date.new(800, 10, 1, Date::GREGORIAN)
    expect(described_class.send(:season)).to eq('fall')
  end

  describe 'activities for the month' do
    it 'finds february\'s activities' do
      described_class.date = Date.new(800, 2, 1, Date::GREGORIAN)

      activities = described_class.months_activities
      expect(activities).to have_key("work_groups")
      expect(activities).to have_key("festivals")
      expect(activities["work_groups"]).to include('prune_grapes')
    end
  end
end

