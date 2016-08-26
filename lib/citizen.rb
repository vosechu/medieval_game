class Citizen
  VALUES = {
    :welcoming_vs_defensive => 50,
    :mystical_vs_logical => 50,
    :generous_vs_fiscally_prudent => 50,
    :strong_military_vs_pacifist => 50,
    :hand_of_divine_vs_self_actualisation => 50,
    :prison_for_life_vs_death_sentence => 50,
    :pro_life_vs_compassionate_death => 50,
    :growth_vs_self_sustenance => 50,
    :fast_acting_vs_calm_under_fire => 50,
    :wanderlust_vs_settling_down => 50,
    :stubborn_vs_flexible => 50,
    :other_focused_vs_self_focused => 50,
    :wisdom_of_ages_vs_openness_of_youth => 50,
    :orderly_govt_vs_dynamic_govt => 50,
    :lawful_vs_means_justify_the_ends => 50
  }

  attr_accessor :village
  attr_accessor :health, :wealth, :satisfaction, :age, :gender
  attr_accessor :highest_rank, :titles
  attr_accessor :values
  attr_accessor :lord, :vassals, :tenants, :fields, :manors
  attr_accessor :parents, :spouse, :children
  attr_accessor :pregnant_at

  def initialize(village: village)
    @village      = village

    @health       = 100
    @wealth       = 100
    @satisfaction = 100
    @age          = 20
    @gender       = 'male'

    @highest_rank = 'serf'
    @titles       = []

    @lord         = Object.new
    @vassals      = []
    @tenants      = []
    @fields       = []
    @manors       = []

    @parents      = {}
    @benefactor   = Object.new # Who will give us stock if they die?
    @beneficiary  = Object.new # Who will receive our stock if I die?
    @spouse       = Object.new
    @pregnant_at  = Time.now
    @children     = []

    @values = VALUES.each_with_object({}) do |(k, v), memo|
      memo[k] = v
    end

    @current_task = Object.new
  end

  def tick
    find_something_to_do
  end

  def self.after_event(_event, _action); end
  def self.before_event(_event, _action); end
  after_event :death, :find_next_beneficiary

  private

  def find_something_to_do
    village.work_groups
    # If it's sunup, start to get up
    # If there's a festival, do that
    # If it's sunday, rest and go to church
    # If I'm in need, deal with that first
    # If I'm the reeve, the priest or a professional, do that
    # If I have a current_task; do that
    # If I'm young; Ask my parents to choose a work_group
    # If I have too little work, pick a work_group at random from the village
    # If I have too much work, advertise a work_group in the village

  end

  def structures
    {
      :barns => [Object.new]
    }
  end

  def vehicles
    {
      :carts => [Object.new]
    }
  end

  def stockpile
    {
      :livestock => {
        :chicken       => :unknown,
        :cock          => :unknown,

        :sheep         => :unknown,
        :lambs         => :unknown,
        :rams          => :unknown,

        :nannies       => :unknown,
        :billies       => :unknown,
        :wethers       => :unknown, # castrated male goat (trained)
        :kids          => :unknown,

        :cows          => :unknown,
        :calves        => :unknown,
        :oxen          => :unknown, # castrated male cow (trained)
        :bulls         => :unknown,

        :sows          => :unknown,
        :piglets       => :unknown,
        :boar          => :unknown,

        :draft_horses  => :unknown, # work horses
        :hackneys      => :unknown, # traveling/pack horses
        :palfreys      => :unknown, # traveling horses
        :chargers      => :unknown, # war horses
      },
      :seed_stock => {
        :rye    => :unknown,
        :oats   => :unknown,
        :wheat  => :unknown,
        :hay    => :unknown,
        :flax   => :unknown,
        :hemp   => :unknown,
        :corn   => :unknown,
        :pulses => :unknown,
      },
      :house_stock => {
        :firewood   => :unknown,
        :herbs      => :unknown,
        :vegetables => :unknown,
        :fruit      => :unknown,
      },
      :stock => {
        :grapes => :unknown,
        :olives => :unknown,
        :pulses => :unknown,

        :hay    => :unknown,
        :rye    => :unknown,
        :oats   => :unknown,
        :wheat  => :unknown,
        :corn   => :unknown,

        :flax   => :unknown,
        :hemp   => :unknown,

        :bees   => :unknown,
      },
      :intermediary => {
        :milk   => :unknown,
        :pork   => :unknown,
        :beef   => :unknown,
        :mutton => :unknown,
        :eggs   => :unknown,
        :honey  => :unknown,
      },
      :secondary => {
        :wine          => :unknown,
        :verjuice      => :unknown,
        :olive_oil     => :unknown,
        :cheese        => :unknown, # 98lb per cow
        :butter        => :unknown, # 14lb per cow
        :charcoal      => :unknown,
        :spun_yarn     => :unknown,
        :woven_cloth   => :unknown,
        :rough_clothes => :unknown,
        :candles       => :unknown,
      }
    }
  end

  def find_work
  end

  def married?
  end
end
