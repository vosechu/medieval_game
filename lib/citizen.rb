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

  attr_accessor :health, :wealth, :satisfaction, :age, :gender
  attr_accessor :highest_rank, :titles
  attr_accessor :values
  attr_accessor :lord, :vassals, :tenants, :fields, :manors
  attr_accessor :parents, :spouse, :children
  attr_accessor :pregnant_at

  def initialize
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
    @spouse       = Object.new
    @pregnant_at  = Time.now
    @children     = []

    @values = VALUES.each_with_object({}) do |(k, v), memo|
      memo[k] = v
    end
  end

  def tick
    married?
  end

  private

  def married?
  end
end
