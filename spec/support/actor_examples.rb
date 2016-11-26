RSpec.shared_examples 'actor' do
  describe '#work' do
    it 'should be implemented' do
      expect { subject.work }.to_not raise_error
    end
  end

  describe '#advertise' do
    xit 'should be implemented' do
      expect { subject.advertise }.to_not raise_error
    end
  end

  describe '#current_ai' do
    xit 'should be implemented' do
      expect { subject.current_ai }.to_not raise_error
    end
  end

  describe '#values' do
    xit 'should be implemented' do
      expect { subject.values }.to_not raise_error
    end
  end
end
