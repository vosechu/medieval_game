require 'field'
require 'stockpile'

# 266-381 days worked per year per family
# 1.13-3.4 d. per day.
class Family
  include Celluloid::Internals::Logger

  attr_reader :stockpile, :fields

  def initialize
    @name = ""

    @head_of_family = Object.new
    @next_in_line = Object.new

    @stockpile    = Stockpile.new
    @fields       = [Field.new]
  end

  def acreage # Total for Weisbach was 45d/acre
    fields.map(&:acreage).reduce(:+)
  end
end
