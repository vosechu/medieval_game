require 'spec_helper'
require 'medieval_game'

describe MedievalGame do
  after :each do
    Calendar.date = Date.new(800, 1, 1, Date::GREGORIAN)
  end

  describe 'timekeeping' do
    it 'updates the date each tick' do
      expect(Calendar.date.day).to eq(1)
      (1.day / Calendar::TICK_LENGTH).times { subject.tick }
      expect(Calendar.date.day).to eq(2)
    end
  end
end
