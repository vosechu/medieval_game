class Village
  attr_accessor :population, :defense_rating, :offense_rating
  attr_accessor :citizens, :council
  attr_accessor :structures, :stockpile, :fields
  attr_accessor :neighbors, :shire

  def initialize
    @population     = 0
    @defense_rating = 0
    @offense_rating = 0

    @citizens       = []
    @council        = []

    @structures     = []
    @stockpile      = []
    @fields         = []
    @jobs           = {}

    @neighbors      = []
    @shire          = Object.new
  end

  def tick
    citizens.map { |c| c.tick }
  end

  private

  def avg(attribute)
    @citizens.map(&attribute).reduce(:+) / @citizens.count
  end
end
