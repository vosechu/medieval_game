require 'contracts'
require 'celluloid/current'

# require 'citizen'
require 'site'
# require 'work_order'
require 'field'
require 'stockpile'

# Interface: ActorCollection
class Village < Site
  include Celluloid
  include Celluloid::Internals::Logger

  include Contracts::Core
  include Contracts::Builtin

  attr_accessor :shire
  # attr_accessor :comm_range
  # attr_accessor :work_orders, :families
  # attr_reader :citizens
  attr_accessor :stockpile, :fields

  def initialize(map: nil, coordinates: nil)
    super(map: map, coordinates: coordinates)

    # # TODO: make a lord object that owns things
    # @lord           = Citizen.new
    # # TODO: make a church object that owns things
    # @priest         = Citizen.new
    # @families       = []
    # # TODO: take the Reeve's work out of the collective labor pool
    # @reeve          = Citizen.new

    @stockpile    = Stockpile.new
    @fields       = []

    # @shire          = Object.new

    # @yearly_labor_levy = 40 # days of service to the lord in exchange for protection
    # @yearly_tax_to_lord = :unknown # percent of goods/wealth sent to lord
    # @yearly_tithe_to_church = :unknown # percent of goods/wealth sent to church

    # @work_orders = []

    # @comm_modifier = 0
  end

  Contract nil => nil
  def tick
    # if Calendar.date.mday == 1
    #   # FIXME: This may be deleting tasks that still need to be done
    #   # TODO: Implement max amount of time to try a thing. Like, we
    #   # could only plant so much this year, so that sucks.
    #   reset_work_orders
    # end

    # advertise if work_orders.empty?
    # assign_citizens_to_work_orders
    work
    # quitting_time

    return nil
  end

  # Contract nil => ArrayOf[Citizen]
  # def citizens
  #   # TODO: Add in some form of caching
  #   families.map(&:members).flatten.compact
  # end

  Contract nil => ArrayOf[Field]
  def fields
    # # TODO: Add in some form of caching
    # families.map(&:fields).flatten # | families.fields | lord.fields | church.fields
    @fields
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

  def work
    # work_orders.reject(&:finished?).map(&:progress)
    case Calendar.date.month
    when 1 # Jan
    when 2 # Feb
    when 3 # Mar
    when 4 # Apr
    when 5 # May
      # First planting
      return if fields.count == 0
      @stockpile.seed_stock -= @fields.map(&:acreage).reduce(:+)
      @fields.map(&:sow)
    when 6 # Jun
    when 7 # Jul
      # Harvest last years winter grain
    when 8 # Aug
      # Harvest spring grains
      return if fields.count == 0
      @stockpile.seed_stock = @fields.map(&:harvest).reduce(:+)
    when 9 # Sep
    when 10 # Oct
      # Plant winter grain
    when 11 # Nov
    when 12 # Dec
    end

    return nil
  end

  # def advertise
  #   self.work_orders = owners.map(&:work_needed).flatten.compact

  #   return nil
  # end

  private

  # def owners
  #   families
  # end

  # def comm_range
  #   super + comm_modifier
  # end

  # def reset_work_orders
  #   if !work_orders.reject(&:finished?).empty?
  #     warn "NOT FINISHED! #{work_orders.reject(&:finished?)}"
  #   end
  #   self.work_orders = []
  # end

  # def assign_citizens_to_work_orders
  #   available_work_orders = work_orders.reject(&:finished?).reject(&:full?)

  #   citizens.reject(&:busy?).each do |citizen|
  #     work_orders = available_work_orders.sample

  #     unless work_orders.nil?
  #       work_orders.sign_up(child: citizen.child?)
  #       citizen.sign_up
  #     end
  #   end

  #   return nil
  # end

  # def quitting_time
  #   work_orders.each do |work_order|
  #     work_order.empty
  #   end
  #   citizens.select(&:busy?).each do |citizen|
  #     citizen.leave
  #   end

  #   return nil
  # end
end
