require 'spec_helper'
require 'medieval_game'

describe MedievalGame do
  describe 'timekeeping' do
    it 'updates the date each tick' do
      expect(subject.date.day).to eq(1)
      (1.day / MedievalGame::TICK_LENGTH).times { subject.tick }
      expect(subject.date.day).to eq(2)
    end

    it 'understands the seasons' do
      expect(subject.season).to eq('winter')
      subject.date += 13.weeks
      expect(subject.season).to eq('spring')
      subject.date += 14.weeks
      expect(subject.season).to eq('summer')
      subject.date += 13.weeks
      expect(subject.season).to eq('fall')
      subject.date += 13.weeks
      expect(subject.season).to eq('winter')
    end
  end
end
