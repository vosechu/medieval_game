require 'integration_spec_helper'
require 'medieval_game'

describe MedievalGame do
  after :each do
    Calendar.date = DateTime.new(800, 1, 1, 0, 0, 0, 0, Date::GREGORIAN)
  end

  it 'runs one tick without exploding' do
    number_of_villages = 10
    number_of_villagers = 100
    number_of_ticks = 1

    game = MedievalGame.new
    number_of_villages.times do
      game.villages << Village.new(map: "", coordinates: "")
    end
    game.villages.each do |village|
      number_of_villagers.times do
        village.citizens << Citizen.new
      end
    end
    number_of_ticks.times do
      expect { game.tick }.to_not raise_error
    end
  end
end
