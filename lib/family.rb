require 'field'
require 'stockpile'

# 266-381 days worked per year per family
# 1.13-3.4 d. per day.
class Family
  include Celluloid::Internals::Logger

  attr_reader :stockpile, :fields

  def initialize(head:, next_in_line:, children:)
    @name = ""

    @head_of_family = head
    @next_in_line = next_in_line
    @children = children || []

    @stockpile    = Stockpile.new
    @fields       = [
      Field.new(acres: 180),
      Field.new(acres: 180),
      Field.new(acres: 180),
    ]
  end

  attr_reader :children
  def adults
    [@head, @next_in_line]
  end

  def acreage # Total for Weisbach was 45d/acre
    fields.map(&:acreage).reduce(:+)
  end
end
