require 'celluloid/current'

class WorkGroup
  include Celluloid::Internals::Logger

  attr_reader :name, :completeness, :adults, :type

  def initialize(name:, max_adults:, person_days:)
    @name         = name
    @max_adults   = max_adults
    @person_days  = person_days
    @completeness = 0
    @adults       = 0
  end

  def finished?
    completeness >= 100
  end

  def full?
    adults == max_adults
  end

  def sign_up
    if adults < max_adults
      self.adults += 1
      return true
    else
      return false
    end
  end

  def empty
    self.adults = 0
  end

  def progress
    self.completeness += adults.fdiv(person_days) * 100

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
    adults.fdiv(max_adults)
  end

  private

  attr_reader :needs, :max_adults, :person_days
  attr_writer :completeness, :adults
end
