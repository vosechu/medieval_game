class Field
  attr_reader :acreage
  attr_accessor :bonus_fertile, :bonus_yield
  attr_accessor :sown_with, :percent_sown, :percent_grown

  def initialize(acres:)
    @acreage       = acres || 10
    @bonus_fertile = 0
    @bonus_yield   = 0
    @percent_sown  = 0
    @percent_grown = 0
  end

  def sown?
    !!@sown_with
  end

  def progress

  end
end
