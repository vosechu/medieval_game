# require 'celluloid/current'

require 'stockpile'
require 'calendar'

class Citizen
  # include Celluloid
  # include Celluloid::Notifications
  # include Celluloid::Internals::Logger

  attr_accessor :village
  # attr_accessor :health, :wealth, :satisfaction, :age, :gender
  # attr_accessor :highest_rank, :titles
  # attr_accessor :lord, :vassals, :tenants, :fields, :manors
  # attr_accessor :parents, :spouse, :children
  # attr_accessor :pregnant_at
  attr_reader :stockpile

  def initialize(village:)
    # subscribe "tick", :tick

    @village      = village

    # @health       = 100
    # @wealth       = 100
    # @satisfaction = 100
    # @age          = 20
    # @gender       = 'male'

    # @highest_rank = 'serf'
    # @titles       = []

    # @lord         = Object.new
    # @vassals      = []
    # @tenants      = []
    # @manors       = []

    @family       = Object.new
    # @parents      = {}
    # @benefactor   = Object.new # Who will give us stock if they die?
    # @beneficiary  = Object.new # Who will receive our stock if I die?
    # @spouse       = Object.new
    # @pregnant_at  = Time.now
    # @children     = []

    @stockpile    = nil

    @current_task = nil
  end

  def tick
    return if sleeping?

    unless busy?
      current_task = find_something_to_do
    end

    do_the_thing

    # if current_task == true
    # else
    #   tick
    # end

    return nil
  end

  # TODO: Does this properly dedup fields that exist in both the
  # family stockpile and the personal stockpile? Also, should that
  # ever happen?
  def fields
    stockpile.fields
    stockpile.fields | family.fields if head_of_family?
  end

  def head_of_family?
    family.head_of_family == self
  end

  # def acreage
  #   fields.map(&:acreage).reduce(:+)
  # end

  def inspect
    "Citizen"
  end

  private

  attr_accessor :current_task

  def find_something_to_do
    # FIXME: This will not work for multi-threaded
    current_workgroup = village.work_groups.sample
    return if current_workgroup.nil?

    if current_workgroup.sign_up(citizen: self)
      self.current_task = current_workgroup
    else
      find_something_to_do
    end
  end

  def do_the_thing
    current_task.progress unless current_task.nil? || current_task.finished?
  end

  def sleeping?
    Calendar.date.hour < 5 || Calendar.date.hour > 22
  end

  def busy?
    !!current_task
  end
end
