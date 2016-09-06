require 'spec_helper'
require 'calendar'

describe Calendar do
  after :each do
    Calendar.date = DateTime.new(800, 1, 1, 0, 0, 0, 0, Date::GREGORIAN)
  end

  describe 'activities for the month' do
    it 'finds february\'s activities' do
      described_class.date = DateTime.new(800, 2, 1, 0, 0, 0, 0, Date::GREGORIAN)

      activities = described_class.months_work_groups
      expect(activities).to include('spring_add_lime_chalk_and_manure')

      activities = described_class.months_festivals
      expect(activities[14]["name"]).to include('Fertility')
    end
  end
end

