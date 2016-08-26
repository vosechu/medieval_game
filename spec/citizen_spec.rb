require 'spec_helper'
require 'citizen'
require 'village'
require 'medieval_game'

describe Citizen do
  subject { described_class.new }

  describe 'initialization' do
    it 'sets the values' do
      stub_const("Citizen::VALUES", {:test => 35})
      expect(subject.values[:test]).to eq(35)
    end
  end

  describe 'lord relationships' do
    it 'allows lords to have tenants' do
      subject.tenants << Citizen.new
      expect(subject.tenants.count).to eq(1)
    end

    it 'allows tenants to have lords' do
      subject.lord = Citizen.new
      subject.lord.tenants << subject
      expect(subject.lord.tenants.count).to eq(1)
    end
  end

  describe 'familial relationships' do

  end

  describe 'within a village' do
    let(:game) { MedievalGame.new }
    let(:village) { Village.new(game: game) }
    subject { described_class.new(village: village) }

    describe 'finding work to do' do
      it 'exercises' do
        subject.tick
      end
    end
  end
end
