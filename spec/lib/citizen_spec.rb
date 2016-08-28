require 'spec_helper'
require 'citizen'

describe Citizen do
  # before :each do
  #   Celluloid.shutdown; Celluloid.boot
  # end

  let(:work_groups) { [instance_double("WorkGroup")] }
  let(:village) { instance_double("Village", :work_groups => work_groups) }
  # NOTE: We must put expectations on the wrapped object when using
  # celluloid Actors
  subject { described_class.new(village: village) }
  # subject { described_class.new(village: village).wrapped_object }

  describe 'within a village' do
    describe 'finding work to do' do
      it 'asks about work available' do
        expect(subject).to receive(:sleeping?).and_return(false)
        expect(subject).to receive(:busy?).and_return(false)
        expect(subject).to receive(:find_something_to_do)
        expect(subject).to receive(:do_the_thing)
        subject.tick
      end
    end
  end
end
