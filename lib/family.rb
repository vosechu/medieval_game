require 'field'
require 'stockpile'

# 266-381 days worked per year per family
# 1.13-3.4 d. per day.
class Family
  attr_reader :stockpile
  attr_accessor :fields

  def initialize(head:, next_in_line:, children:)
    @name = ""

    @head_of_family = head
    @next_in_line = next_in_line
    @children = children || []

    @stockpile    = Stockpile.new
    @fields       = []
  end

  attr_reader :children
  def adults
    [@head, @next_in_line]
  end

  def acreage # Total for Weisbach was 45d/acre
    fields.map(&:acreage).reduce(:+)
  end
end
