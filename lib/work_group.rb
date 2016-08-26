class WorkGroup
  attr_accessor :citizens

  def initialize(name: name, needs: needs)
    @name     = name
    @needs   = needs
    @citizens = []
  end


end
