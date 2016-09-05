require 'spec_helper'
require 'work_group'
require 'actor_collection_examples'

describe WorkGroup do
  it_behaves_like 'actor_collection'

  subject {
    described_class.new(
      name: "test",
      max_adults: 2,
      max_children: 2,
      person_days: 40
    )
  }
  let(:village) { instance_double("Village") }

  describe 'full work group' do
    before :each do
      subject.sign_up
      subject.sign_up
      subject.sign_up(child: true)
      subject.sign_up(child: true)
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
      subject.sign_up
      subject.sign_up(child: true)
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
