# require 'celluloid/current'

require 'stockpile'
require 'calendar'

class Citizen
  # include Celluloid
  # include Celluloid::Notifications
  # include Celluloid::Internals::Logger

  attr_accessor :village
  attr_accessor :health, :wealth, :satisfaction, :age, :gender
  attr_accessor :highest_rank, :titles
  attr_accessor :lord, :vassals, :tenants, :fields, :manors
  attr_accessor :parents, :spouse, :children
  attr_accessor :pregnant_at

  def initialize(village:)
    # subscribe "tick", :tick

    @village      = village

    @health       = 100
    @wealth       = 100
    @satisfaction = 100
    @age          = 20
    @gender       = 'male'

    @highest_rank = 'serf'
    @titles       = []

    # @lord         = Object.new
    # @vassals      = []
    # @tenants      = []
    # @manors       = []

    @head_of_family = true
    @family       = Object.new
    @parents      = {}
    @benefactor   = Object.new # Who will give us stock if they die?
    @beneficiary  = Object.new # Who will receive our stock if I die?
    @spouse       = Object.new
    @pregnant_at  = Time.now
    @children     = []

    @stockpile    = nil

    @current_task = nil
  end

  def tick
    find_something_to_do
    do_the_thing

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
    @head_of_family
  end

  def acreage
    fields.map(&:acreage).reduce(:+)
  end

  def inspect
    "Citizen"
  end

  private

  attr_accessor :current_task

  def find_something_to_do
    # FIXME: This will not work for multi-threaded
    return if busy?

    current_task = village.work_groups.first.sign_up(citizen: self)
  end

  def do_the_thing
    current_task.progress unless current_task.finished?
  end

  def busy?
    !!current_task
  end

  def find_work
  end

  def married?
  end
end
