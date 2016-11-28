require 'spec_helper'
require 'jobs/fields/plant_field_job'
require 'job_examples'

describe PlantFieldJob do
  it_behaves_like 'job'

  let(:field) { instance_double('Field', :reserve => nil, :unreserve => nil, :percent_sown => 15, :percent_sown= => nil)}
  let(:worker) { instance_double('worker', :busy= => nil, :tired= => nil)}
  let(:store) { instance_double('Stockpile', :reserve_seed_stock => nil, :remove_seed_stock => nil, :unreserve_seed_stock => nil)}

  subject { described_class.new(field: field, workers: [worker], store: store) }

  describe '#on_create' do
  end

  describe '#before_work' do
  end

  describe '#on_work' do
    it 'does something' do
      subject.work
    end
  end

  describe '#on_rescue' do
    it 'unreserves stock on exception' do
      expect(store).to receive(:unreserve_seed_stock).with(10)
      allow(subject).to receive(:on_work).and_raise('fake error')
      expect { subject.work }.to raise_error('fake error')
    end
  end

  describe '#on_finalize' do
  end
end
