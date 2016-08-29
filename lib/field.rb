class Field
  attr_reader :acreage

  def initialize(acres:)
    @acreage = acres || 10
  end
end
