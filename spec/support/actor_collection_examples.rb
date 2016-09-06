RSpec.shared_examples 'actor_collection' do
  describe '#work' do
    it 'should be implemented' do
      expect { subject.work }.to_not raise_error
    end
  end

  describe '#join' do
    xit 'should be implemented' do
      expect { subject.join }.to_not raise_error
    end
  end

  describe '#leave' do
    xit 'should be implemented' do
      expect { subject.leave }.to_not raise_error
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
