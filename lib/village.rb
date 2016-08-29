require 'celluloid/current'

require 'citizen'
require 'site'
require 'work_group'
require 'field'
require 'stockpile'

class Village < Site
  include Celluloid
  include Celluloid::Notifications
  include Celluloid::Internals::Logger

  attr_accessor :shire
  attr_accessor :comm_range
  attr_accessor :work_groups
  attr_reader :citizens

  def initialize(map: nil, coordinates: nil)
    super(map: map, coordinates: coordinates)

    # TODO: make a lord object that owns things
    @lord           = Citizen.new
    # TODO: make a church object that owns things
    @priest         = Citizen.new
    @citizens       = []
    @families       = []
    # TODO: take the Reeve's work out of the collective labor pool
    @reeve          = Citizen.new

    @stockpile    = Stockpile.new
    @fields       = [Field.new]

    @shire          = Object.new

    # @yearly_labor_levy = 40 # days of service to the lord in exchange for protection
    # @yearly_tax_to_lord = :unknown # percent of goods/wealth sent to lord
    # @yearly_tithe_to_church = :unknown # percent of goods/wealth sent to church

    @work_groups = []

    @comm_modifier = 0
  end

  def tick
    if Calendar.date.mday == 1 && Calendar.date.hour == 1
      reset_work_groups
    end

    if Calendar.date.hour > 5 && Calendar.date.hour < 22
      generate_work_groups if work_groups.empty?
      assign_citizens_to_work_groups
      get_shit_done
    else
      quitting_time
    end

    return nil
  end

  # def fields
  #   citizens.map(&:fields) | lord.fields | church.fields
  # end

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

  private

  def comm_range
    super + comm_modifier
  end

  def reset_work_groups
    self.work_groups = []
  end

  def generate_work_groups
    self.work_groups = Calendar.months_activities["work_groups"].map do |name, needs|
      WorkGroup.new(name: name, needs: needs)
    end

    return nil
  end

  def assign_citizens_to_work_groups
    available_work_groups = work_groups.reject(&:finished?).reject(&:full?)

    citizens.reject(&:busy?).each do |citizen|
      wg = available_work_groups.sample

      unless wg.nil?
        wg.sign_up
        citizen.sign_up
      end
    end

    return nil
  end

  def get_shit_done
    work_groups.reject(&:finished?).each do |work_group|
      work_group.progress
    end

    return nil
  end

  def quitting_time
    work_groups.each do |work_group|
      work_group.empty
    end
    citizens.select(&:busy?).each do |citizen|
      citizen.leave
    end

    return nil
  end
end
