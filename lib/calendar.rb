require 'yaml'
require 'active_support/core_ext/numeric/time'
require 'contracts'

class Calendar
  include Contracts::Core
  include Contracts::Builtin

  TICK_LENGTH = 1.hour

  class << self
    Contract nil => DateTime
    def date
      @date ||= DateTime.new(800, 1, 1, 0, 0, 0, 0, Date::GREGORIAN)
    end

    Contract DateTime => nil
    def date=(date)
      @date = date

      return nil
    end

    Contract nil => nil
    def tick
      Calendar.date += Calendar::TICK_LENGTH

      return nil
    end

    Contract nil => HashOf[Num => Hash["name" => String, "description" => String]]
    def months_festivals
      months_activities["festivals"]
    end

    Contract nil => HashOf[String => HashOf[String => Hash]]
    def months_work_orders
      months_activities["work_orders"]
    end

    private

    def month_name
      date.strftime("%B").downcase
    end

    def months_activities
      {
        "festivals"   => festivals[month_name] || {},
        "work_orders" => work_orders[month_name] || {}
      }
    end

    def festivals
      @festivals ||= begin
        yaml = yaml_load("festivals")
        yaml[yaml["set_to_use"]]
      end
    end

    def work_orders
      @work_orders ||= begin
        yaml = yaml_load("work_orders")
        yaml[yaml["set_to_use"]]
      end
    end

    def yaml_load(file)
      File.open("config/#{file}.yml") { |file| YAML.load(file) }
    end
  end
end
