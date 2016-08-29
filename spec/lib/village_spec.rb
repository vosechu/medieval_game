require 'spec_helper'
require 'village'

describe Village do
  after :each do
    Calendar.date = DateTime.new(800, 1, 1, 0, 0, 0, 0, Date::GREGORIAN)
  end

  describe '#reset_work_groups' do
    before :each do
      allow(subject.wrapped_object).to receive(:generate_work_groups)
    end

    it 'resets on the first of the month' do
      Calendar.date = DateTime.new(800, 1, 1, 1, 0, 0, 0, Date::GREGORIAN)

      subject.work_groups = [instance_double("WorkGroup")]
      subject.send(:reset_work_groups)
      expect(subject.work_groups).to eq([])
    end
  end

  describe '#tick' do
    it 'resets in the first hour of the month' do
      Calendar.date = DateTime.new(800, 1, 1, 1, 0, 0, 0, Date::GREGORIAN)

      expect(subject.wrapped_object).to receive(:reset_work_groups)
      subject.tick
    end

    it 'orchestrates work during working hours' do
      Calendar.date = DateTime.new(800, 1, 1, 6, 0, 0, 0, Date::GREGORIAN)

      expect(subject.wrapped_object).to receive(:generate_work_groups)
      expect(subject.wrapped_object).to receive(:assign_citizens_to_work_groups)
      expect(subject.wrapped_object).to receive(:get_shit_done)
      subject.tick
    end

    it 'sends citizens to bed outside of working hours' do
      Calendar.date = DateTime.new(800, 1, 1, 23, 0, 0, 0, Date::GREGORIAN)

      expect(subject.wrapped_object).to receive(:quitting_time)
      subject.tick
    end
  end
end
