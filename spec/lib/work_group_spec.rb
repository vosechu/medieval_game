require 'spec_helper'
require 'work_group'

describe WorkGroup do
  subject {
    described_class.new(
      name: "test",
      needs: { "fixed_per_day" => { "adults" => 2, "days" => 10 } }
    )
  }
  let(:village) { instance_double("Village") }
  let(:citizen1) { instance_double("Citizen", :village => village) }
  let(:citizen2) { instance_double("Citizen", :village => village) }

  describe 'full work group' do
    before :each do
      subject.sign_up(citizen: citizen1)
      subject.sign_up(citizen: citizen2)
    end

    it 'reports that it is full' do
      expect(subject.full?).to be true
    end

    it 'progresses' do
      expect(subject.completeness).to eq(0)
      subject.progress
      expect(subject.completeness).to eq(10)
    end

    it 'finishes' do
      expect(subject.completeness).to eq(0)
      10.times { subject.progress }
      expect(subject.completeness).to eq(100)
    end
  end

  describe 'half-full work group' do
    before :each do
      subject.sign_up(citizen: citizen1)
    end

    it 'reports that it is not full' do
      expect(subject.full?).to be false
    end

    it 'progresses' do
      expect(subject.completeness).to eq(0)
      subject.progress
      expect(subject.completeness).to eq(5)
    end
  end
end
