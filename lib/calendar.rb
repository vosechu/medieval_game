require 'active_support/core_ext/numeric/time'

class Calendar
  TICK_LENGTH = 1.hour

  class << self
    def date
      @date ||= Date.new(800, 1, 1, Date::GREGORIAN)
    end
    def date=(date)
      @date = date
    end

    def increment_date!
      @date += TICK_LENGTH
    end

    def festivals
      @festivals ||= yaml_load("festivals")
    end

    def work_groups
      @work_groups ||= yaml_load("work_groups")
    private

    def month_name
      date.strftime("%B").downcase
    end

    def season
      case date.month
      when 1..3
        'winter'
      when 4..6
        'spring'
      when 7..9
        'summer'
      when 10..12
        'fall'
      end
    end


    def yaml_load(file)
      File.open("config/#{file}.yml") { |file| YAML.load(file) }
    end
  end
end
