$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'citizen'
require 'village'
require 'active_support/core_ext/numeric/time'

class MedievalGame
  TICK_LENGTH = 1.minute

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

  Benchmark.bm do |results|
    results.report("init:") do
      game = MedievalGame.new
    end
    results.report("init villages:") do
      9000.times do
        game.villages << Village.new
      end
    end
    game.villages.each do |village|
      results.report("init citizens:") do
        500.times do
          village.citizens << Citizen.new
        end
      end
    end
    results.report("tick:") do
      365*24*60.times do
        game.tick
      end
    end
  end
end
