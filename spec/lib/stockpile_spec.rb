require 'spec_helper'
require 'stockpile'

describe Stockpile do
  describe '#reserve_x' do
    before(:each) do
      subject.seed_stock = 100
    end

    it 'can reserve seed stock' do
      expect { subject.reserve_seed_stock(10) }
        .to change { subject.reserved_seed_stock }.by(10)
      expect { subject.reserve_seed_stock(10) }
        .to change { subject.seed_stock }.by(-10)
    end

    it 'returns the total amount reserved' do
      expect(subject.reserve_seed_stock(10)).to eq(10)
    end

    it 'returns less if there is not enough stock to return' do
      expect(subject.reserve_seed_stock(101)).to eq(100)
    end
  end
end
