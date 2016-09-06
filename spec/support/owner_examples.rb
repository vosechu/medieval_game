RSpec.shared_examples 'owner' do
  describe '#advertise' do
    xit 'should be implemented' do
      expect { subject.fields }.to_not raise_error
    end
  end

  describe '#fields' do
    it 'should be implemented' do
      expect { subject.fields }.to_not raise_error
    end
  end

  describe '#stockpile' do
    it 'should be implemented' do
      expect { subject.stockpile }.to_not raise_error
    end
  end
end
