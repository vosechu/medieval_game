require 'spec_helper'
require 'jobs/fields/plant_field_job'
require 'job_examples'

describe PlantFieldJob do
  it_behaves_like 'job'

  let(:field) { instance_double('Field', :reserve => nil, :unreserve => nil, :percent_sown => 15, :percent_sown= => nil, :sown? => false)}
  let(:worker) { instance_double('worker', :busy= => nil, :tired= => nil)}
  let(:store) { instance_double('Stockpile', :reserve_seed_stock => nil, :remove_seed_stock => nil, :unreserve_seed_stock => nil)}

  subject { described_class.new(field: field, workers: [worker], store: store) }

  before(:each) do
    allow(subject).to receive(:percent_seed_stock).and_return(1)
    allow(subject).to receive(:percent_workers).and_return(1)
  end

  describe '#on_create' do
    it 'reserves the field' do
      expect(field).to receive(:reserve)

      described_class.new(field: field, workers: [worker], store: store)
    end

    it 'reserves the workers' do
      expect(worker).to receive(:busy=)

      described_class.new(field: field, workers: [worker], store: store)
    end

    it 'reserves the seed stock' do
      expect(store).to receive(:reserve_seed_stock)

      described_class.new(field: field, workers: [worker], store: store)
    end
  end

  describe '#before_work' do
  end

  describe '#on_work' do
    it 'removes the seed stock' do
      expect(store).to receive(:remove_seed_stock)

      subject.work
    end

    it 'exhausts the workers' do
      expect(worker).to receive(:tired=)

      subject.work
    end

    it 'increases the percent_sown' do
      expect(field).to receive(:percent_sown=)

      subject.work
    end

    it 'increases the percent_sown relative to the amount of seed' do
      allow(subject).to receive(:percent_seed_stock).and_return(0.8)
      allow(field).to receive(:percent_sown).and_return(0)

      expect(field).to receive(:percent_sown=).with(5.0 * 1 * 0.8)

      subject.work
    end

    it 'increases the percent_sown relative to the amount of workers' do
      allow(subject).to receive(:percent_workers).and_return(0.8)
      allow(field).to receive(:percent_sown).and_return(0)

      expect(field).to receive(:percent_sown=).with(5.0 * 0.8 * 1)

      subject.work
    end

    it 'asks to increases percent_sown past 100 without a care' do
      allow(field).to receive(:percent_sown).and_return(100)

      expect(field).to receive(:percent_sown=).with(100 + 5.0)

      subject.work
    end
  end

  describe '#on_rescue' do
    it 'unreserves stock on exception' do
      allow(subject).to receive(:on_work).and_raise('fake error')

      expect(store).to receive(:unreserve_seed_stock)

      expect { subject.work }.to raise_error('fake error')
    end
  end

  describe '#on_finalize' do
    it 'releases the workers' do
      expect(worker).to receive(:busy=).with(false)

      subject.work
    end

    it 'releases the field' do
      expect(field).to receive(:unreserve)

      subject.work
    end
  end
end
