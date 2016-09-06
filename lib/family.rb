require 'contracts'
require 'celluloid/current'

require 'field'
require 'stockpile'
require 'work_order'
require 'citizen'

# 266-381 days worked per year per family
# 1.13-3.4 d. per day.
#
# Interface: ActorCollection
class Family
  include Celluloid::Internals::Logger

  include Contracts::Core
  include Contracts::Builtin

  attr_reader :stockpile
  attr_reader :children
  attr_accessor :fields

  def initialize(head:, next_in_line:, children:)
    @name = ""

    @head_of_family = head
    @next_in_line = next_in_line
    @children = children || []

    @stockpile    = Stockpile.new
    @fields       = []
  end

  def adults
    [@head, @next_in_line].compact
  end

  Contract nil => ArrayOf[Citizen]
  def all
    (adults + children).compact.flatten
  end

  Contract nil => Num
  def acreage # Total for Weisbach was 45d/acre
    fields.map(&:acreage).reduce(:+)
  end

  def work
    all.map(&:work)
  end

  Contract nil => ArrayOf[WorkOrder]
  def advertise
    wg = []

    Calendar.months_work_orders.each do |name, needs|
      type = needs.keys.first
      values = needs.values.first

      # info "name: #{name}, type: #{type} values: #{values}"

      case type
      when "fixed_per_day"
        wg << WorkOrder.new(
          name: name,
          min_adults: values["min_adults"],
          max_adults: values["max_adults"],
          min_children: values["min_children"],
          max_children: values["max_children"],
          person_days: values["person_days"]
        )
      when "acres_per_day"
        fields.each do |field|
          wg << WorkOrder.new(
            name: "#{name} #{field.object_id}",
            min_adults: values["min_adults"] || 0,
            max_adults: field.acreage.fdiv(values['per_adult']),
            person_days: field.acreage.fdiv(values['per_adult'])
          )
        end
      end
    end

    return wg
  end
end
