require 'spec_helper'
require 'stockpile'

describe Stockpile do
  describe '#reserve_x' do
    it 'can reserve seed stock' do
      subject.seed_stock = 100
      expect { subject.reserve_seed_stock(10) }
        .to change { subject.reserved_seed_stock }.by(10)
      expect { subject.reserve_seed_stock(10) }
        .to change { subject.seed_stock }.by(-10)
    end
  end
end
