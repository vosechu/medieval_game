class Field
  attr_reader :acreage
  attr_accessor :sown_with, :sown_on, :coverage, :maturity

  def initialize(acres:)
    @acreage  = acres || 10
    @maturity = 0
  end

  def sown?
    !!@sown_with
  end

  def progress

  end
end
