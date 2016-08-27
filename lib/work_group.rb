class WorkGroup
  attr_accessor :citizens

  def initialize(name:, needs:)
    @name     = name
    @needs    = needs
    @citizens = []
  end
end
