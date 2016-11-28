RSpec.shared_examples 'job' do
  describe '#on_create' do
    it 'should be implemented' do
      expect(subject.respond_to?(:on_create, true)).to be true
    end
  end

  describe '#before_work' do
    it 'should be implemented' do
      expect(subject.respond_to?(:before_work, true)).to be true
    end
  end

  describe '#on_work' do
    it 'should be implemented' do
      expect(subject.respond_to?(:on_work, true)).to be true
    end
  end

  describe '#on_rescue' do
    it 'should be implemented' do
      expect(subject.respond_to?(:on_rescue, true)).to be true
    end
  end

  describe '#on_finalize' do
    it 'should be implemented' do
      expect(subject.respond_to?(:on_finalize, true)).to be true
    end
  end
end
