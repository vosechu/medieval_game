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
    @adults << citizen

    return nil
  end

  private

  attr_reader :needs, :type, :adults, :children

  def adults_needed
    case type
    when "fixed_per_day"
      needs["adults"] || 0
    end
  end

  def children_needed
    case type
    when "fixed_per_day"
      needs["children"] || 0
    end
  end

  def duration
    case type
    when "fixed_per_day"
      needs["days"] || 0
    end
  end
end
