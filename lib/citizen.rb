require 'field'
require 'stockpile'
require 'calendar'

class Citizen
  attr_accessor :current_task
  # attr_accessor :health, :wealth, :satisfaction, :age, :gender
  # attr_accessor :highest_rank, :titles
  # attr_accessor :parents, :spouse, :children
  # attr_accessor :pregnant_at
  attr_reader :stockpile, :fields

  attr_accessor :busy

  def initialize(child: false)
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

    # @family       = Object.new
    # @parents      = {}
    # @benefactor   = Object.new # Who will give us stock if they die?
    # @beneficiary  = Object.new # Who will receive our stock if I die?
    # @spouse       = Object.new
    # @pregnant_at  = Time.now
    # @children     = []

    @child        = child

    @stockpile    = Stockpile.new
    @fields       = [Field.new(acres: 10)]

    @busy = false
  end

  def child?
    !!@child
  end

  def sign_up
    self.busy = true
  end

  def leave
    self.busy = false
  end

  # # TODO: Does this properly dedup fields that exist in both the
  # # family stockpile and the personal stockpile? Also, should that
  # # ever happen?
  # def fields
  #   stockpile.fields
  #   stockpile.fields | family.fields if head_of_family?
  # end

  def acreage # Total for Weisbach was 45d/acre
    fields.map(&:acreage).reduce(:+)
  end

  def busy?
    !!self.busy
  end

  def inspect
    "Citizen, busy: #{busy?}"
  end
end
