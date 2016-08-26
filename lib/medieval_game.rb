$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'citizen'
require 'village'
require 'active_support/core_ext/numeric/time'

class MedievalGame
  TICK_LENGTH = 1.hour

  attr_accessor :villages, :date

  def initialize
    @date = Date.new(800, 1, 1)
    @date.new_start(Date::GREGORIAN)

    @villages = []
  end

  def tick
    @date += TICK_LENGTH
    villages.map { |village| village.tick }
  end

  def season
    case date.month
    when 1..3
      'winter'
    when 4..6
      'spring'
    when 7..9
      'summer'
    when 10..12
      'fall'
    end
  end
end

if $PROGRAM_NAME == __FILE__
  require 'benchmark'
  game = nil

  number_of_villages = 1
  # number_of_villages = 9000
  number_of_villagers = 10
  # number_of_villagers = 500
  number_of_ticks = 52.weeks / MedievalGame::TICK_LENGTH

  Benchmark.bm(13) do |results|
    results.report("init:") do
      game = MedievalGame.new
    end
    results.report("init villages:") do
      number_of_villages.times do
        game.villages << Village.new(game: game)
      end
    end
    game.villages.each do |village|
      results.report("init citizens:") do
        number_of_villagers.times do
          village.citizens << Citizen.new(village: village)
        end
      end
    end
    results.report("one year:") do
      number_of_ticks.times do
        game.tick
      end
    end
  end
end
