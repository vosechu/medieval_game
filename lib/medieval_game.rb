$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'citizen'
require 'village'

require 'benchmark'

class MedievalGame
  def initialize
    Benchmark.bm { |bm|
      village = Village.new
      bm.report("init: ") {
        500000.times do
          village.citizens << Citizen.new
        end
      }
      bm.report("tick 1:") {
        village.tick
      }
      bm.report("tick 2:") {
        village.tick
      }
      bm.report("tick 3:") {
        village.tick
      }
      bm.report("tick 4:") {
        village.tick
      }
      bm.report("tick 5:") {
        village.tick
      }
      bm.report("tick 5-100:") {
        95.times { village.tick }
      }
    }
  end
end

if $PROGRAM_NAME == __FILE__
  MedievalGame.new
end
