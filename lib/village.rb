require 'reeve'
require 'citizen'
require 'site'

class Village < Site
  attr_accessor :game
  attr_accessor :population, :defense_rating, :offense_rating
  attr_accessor :citizens, :reeve
  attr_accessor :structures, :stockpile, :fields
  attr_accessor :shire
  attr_accessor :comm_range

  def initialize(game:, map: nil, coordinates: nil)
    super(map, coordinates)

    @game           = game

    # @defense_rating = 0
    # @offense_rating = 0

    # TODO: make a lord object that owns things
    @lord           = Citizen.new(village: self)
    # TODO: make a church object that owns things
    @church         = Citizen.new(village: self)
    @citizens       = []
    @families       = []
    # TODO: take the Reeve's work out of the collective labor pool
    @reeve          = Reeve.new(village: self)

    # @structures     = []
    @stockpile      = []

    @shire          = Object.new

    # @yearly_labor_levy = 40 # days of service to the lord in exchange for protection
    # @yearly_tax_to_lord = :unknown # percent of goods/wealth sent to lord
    # @yearly_tithe_to_church = :unknown # percent of goods/wealth sent to church

    @comm_modifier = 0
  end

  def tick
    citizens.map { |c| c.tick }

    return nil
  end

  def fields
    citizens.map(&:fields) | lord.fields | church.fields
  end

  # def professionals
  #   {
  #     :bakers => [Citizen.new],
  #     :blacksmiths => [Citizen.new],
  #     :potter => [Citizen.new],
  #     :priest => [Citizen.new],
  #     :carpenters => [Citizen.new, Citizen.new], # "a couple"
  #     :masons => [Citizen.new, Citizen.new] # "a couple"
  #   }
  # end

  # def structures
  #   {
  #     :mill => Object.new(cost: "unknown", owner: Object.new, benefit: "100%"),
  #     :wine_press => Object.new(cost: "unknown", owner: Object.new, benefit: "115%"),
  #     :olive_press => Object.new
  #   }
  # end

  def work_groups
    reeve.work_groups
  end

  private

  # def population
  #   @citizens.count
  # end

  # def avg(attribute)
  #   @citizens.map(&attribute).reduce(:+) / @citizens.count
  # end

  def comm_range
    super + comm_modifier
  end
end
