require 'celluloid/current'

class WorkGroup
  include Celluloid::Internals::Logger

  attr_reader :name, :completeness, :adults, :type

  def initialize(name:, needs:)
    @name         = name
    @needs        = needs[needs.keys[0]]
    @type         = needs.keys[0]
    @completeness = 0
    @adults       = []
  end

  def finished?
    completeness >= 100
  end

  def full?
    adults.count == adults_needed
  end

  def sign_up(citizen:)
    if adults.count < adults_needed
      self.adults << citizen
      return true
    else
      return false
    end
  end

  def empty
    self.adults = []
  end

  def progress
    case type
    when "fixed_per_day"
      self.completeness += fullness.fdiv(duration) * 100
    end

    # if finished?
    #   info "DONE! #{name}"
    # else
    #   info "Progress: #{completeness} #{name}"
    # end

    return nil
  end

  def to_s
    "#{name}: fullness - #{fullness}, progress - #{completeness}"
  end

  def fullness
    adults.count.fdiv(max_workers)
  end

  private

  attr_reader :needs
  attr_writer :completeness, :adults

  def max_workers
    adults_needed
  end

  def adults_needed
    case type
    when "fixed_per_day"
      needs["adults"] || 0
    end
  end

  def duration
    case type
    when "fixed_per_day"
      needs["days"] || 0
    end
  end
end
