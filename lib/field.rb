require 'contracts'

class Field
  include Contracts::Core
  include Contracts::Builtin

  attr_reader :acreage
  attr_accessor :bonus_fertile, :bonus_yield
  attr_accessor :sown_with, :percent_sown, :percent_grown, :percent_harvested

  def initialize(acres:)
    @acreage           = acres || 10
    @bonus_fertile     = 0
    @bonus_yield       = 0
    @percent_sown      = 0
    @percent_grown     = 0
    @percent_harvested = 0
  end

  Contract nil => nil
  def sow
    @percent_sown = 100

    return nil
  end

  Contract nil => Num
  def harvest
    if @percent_sown == 100
      @percent_sown = 0

      return @acreage * 2.0
    end
    return 0.0
  end

  def sown?
    !!@percent_sown == 100
  end

  def progress

  end

  def reserve
    @reserved = true
  end
  def unreserve
    @reserved = false
  end
  def reserved?
    !!@reserved
  end
end
