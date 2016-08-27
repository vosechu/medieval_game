require 'reeve'
require 'citizen'

class Village
  attr_accessor :game
  attr_accessor :population, :defense_rating, :offense_rating
  attr_accessor :citizens, :reeve
  attr_accessor :structures, :stockpile, :fields
  attr_accessor :neighbors, :shire

  def initialize(game:)
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

    # @neighbors      = []
    # @shire          = Object.new

    # @yearly_labor_levy = 40 # days of service to the lord in exchange for protection
    # @yearly_tax_to_lord = :unknown # percent of goods/wealth sent to lord
    # @yearly_tithe_to_church = :unknown # percent of goods/wealth sent to church
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
end
