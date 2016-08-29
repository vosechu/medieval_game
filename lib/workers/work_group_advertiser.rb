require 'celluloid/current'

class WorkGroupAdvertiser
  include Celluloid

  def initialize
  end

  def call(village:, fields:, name:, needs:)
    type = needs.keys.first
    values = needs.values.first

    case type
    when "fixed_per_day"
      village.async.advertise_work_group(
        name: name,
        max_adults: values["max_adults"],
        max_children: values["max_children"],
        person_days: values["person_days"]
      )
    when "per_acre_per_day"
      fields.map do |field|
        village.async.advertise_work_group(
          name: "#{name} #{field.object_id}",
          max_adults: ((values["max_adults"] || 0) * field.acreage).ceil,
          max_children: ((values["max_children"] || 0) * field.acreage).ceil,
          person_days: ((values["max_adults"] || 0) + (values["max_children"] || 0)) * field.acreage
        )
      end
    end
  end
end
