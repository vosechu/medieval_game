$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'citizen'
require 'village'

class MedievalGame
  def initialize
    village = Village.new
    500.times do
      village.citizens << Citizen.new
    end
    365.times do
      village.tick
    end
  end
end

if $PROGRAM_NAME == __FILE__
  MedievalGame.new
end
