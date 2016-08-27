require 'calendar'
require 'work_group'

class Reeve
  attr_reader :village

  def initialize(village:)
    @village = village
    @work_groups_cache = {}
  end

  def work_groups
    # TODO: How to remove/reset a workgroup for next year
    lookup_default_work_groups
    available_work_groups
  end

  # TODO: Individuals should advertise their needs, not just the reeve
  # Though my reading suggests perhaps otherwise, or maybe just
  # that the reeve took care of the lord/church lands
  def advertise_work_group(name:, needs:)
    return if work_groups_cache[name]

    work_groups_cache[name] = WorkGroup.new(name: name, needs: needs)

    return nil
  end

  private

  attr_accessor :work_groups_cache

  def lookup_default_work_groups
    # TODO: Figure out how to cache this intelligently
    wg = Calendar.months_activities["work_groups"]
    wg.map do |name, needs|
      advertise_work_group(name: name, needs: needs)
    end

    return nil
  end

  def available_work_groups
    work_groups_cache
      .values
      .reject(&:finished?)
      .reject(&:full?)
  end
end
