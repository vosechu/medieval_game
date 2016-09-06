require 'celluloid/current'

require 'citizen'
require 'site'
require 'work_order'
require 'field'
require 'stockpile'

# Interface: ActorCollection
class Village < Site
  include Celluloid
  include Celluloid::Internals::Logger

  attr_accessor :shire
  attr_accessor :comm_range
  attr_accessor :work_orders, :families
  attr_reader :citizens

  def initialize(map: nil, coordinates: nil)
    super(map: map, coordinates: coordinates)

    # TODO: make a lord object that owns things
    @lord           = Citizen.new
    # TODO: make a church object that owns things
    @priest         = Citizen.new
    @families       = []
    # TODO: take the Reeve's work out of the collective labor pool
    @reeve          = Citizen.new

    @stockpile    = Stockpile.new
    @fields       = [Field.new(acres: 10)]

    @shire          = Object.new

    # @yearly_labor_levy = 40 # days of service to the lord in exchange for protection
    # @yearly_tax_to_lord = :unknown # percent of goods/wealth sent to lord
    # @yearly_tithe_to_church = :unknown # percent of goods/wealth sent to church

    @work_orders = []

    @comm_modifier = 0
  end

  def tick
    if Calendar.date.mday == 1 && Calendar.date.hour == 1
      # FIXME: This may be deleting tasks that still need to be done
      # TODO: Implement max amount of time to try a thing. Like, we
      # could only plant so much this year, so that sucks.
      reset_work_orders
    end

    if Calendar.date.hour > 5 && Calendar.date.hour < 22
      advertise if work_orders.empty?
      assign_citizens_to_work_orders
      work
    else
      quitting_time
    end

    return nil
  end

  def citizens
    citizens = families.map do |family|
      [family.adults, family.children]
    end
    citizens.flatten.compact
  end

  def fields
    families.map(&:fields).flatten # | families.fields | lord.fields | church.fields
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

  def advertise_work_order(name:, max_adults:, max_children:, person_days:)
    self.work_orders << WorkOrder.new(
      name: name,
      max_adults: max_adults,
      max_children: max_children,
      person_days: person_days
    )
  end

  def work
    work_orders.reject(&:finished?).each do |work_order|
      work_order.progress
    end

    return nil
  end

  def advertise
    work_orders = owners.map(&:advertise)

    return nil
  end

  private

  def owners
    families
  end

  def comm_range
    super + comm_modifier
  end

  def reset_work_orders
    # info "NOT FINISHED! #{self.work_orders.reject(&:finished?)}"
    self.work_orders = []
  end

  def assign_citizens_to_work_orders
    available_work_orders = work_orders.reject(&:finished?).reject(&:full?)

    citizens.reject(&:busy?).each do |citizen|
      wo = available_work_orders.sample

      unless wo.nil?
        wo.sign_up(child: citizen.child?)
        citizen.sign_up
      end
    end

    return nil
  end

  def quitting_time
    work_orders.each do |work_order|
      work_order.empty
    end
    citizens.select(&:busy?).each do |citizen|
      citizen.leave
    end

    return nil
  end
end
