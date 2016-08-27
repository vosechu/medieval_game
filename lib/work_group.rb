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

    return self
  end

  def progress
    case type
    when "fixed_per_day"
      @completeness += fullness.fdiv(duration) * 100
    end
  end

  private

  attr_reader :needs, :type, :adults, :children
  attr_writer :completeness

  def max_workers
    adults_needed + children_needed
  end

  def fullness
    (@adults.count + @children.count).fdiv(max_workers)
  end

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
