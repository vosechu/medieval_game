class WorkGroup
  attr_accessor :citizens
  attr_reader :completeness

  def initialize(name:, needs:)
    @name         = name
    @needs        = needs[needs.keys[0]]
    @type         = needs.keys[0]
    @completeness = 0
    @adults       = []
    @children     = []
  end

  def finished?
    completeness == 100
  end

  def full?
    adults.count == adults_needed &&
      children.count == children_needed
  end

  def sign_up(citizen:)
    @citizens << citizen
  end

  private

  attr_reader :needs, :type, :adults, :children

  def adults_needed
    case type
    when "fixed_per_day"
      needs["adults"]
    end
  end

  def children_needed
    case type
    when "fixed_per_day"
      needs["children"]
    end
  end

  def duration
    case type
    when "fixed_per_day"
      needs["days"]
    end
  end
end
