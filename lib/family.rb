class Family
  def initialize
    @name = ""
    @fields = []

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
      :live_stock => live_stock,
      :seed_stock => seed_stock,
      :house_stock => house_stock,
      :raw_stock => raw_stock,
      :intermediary_goods => intermediary_goods,
      :secondary_goods => secondary_goods
    }
  end

  def live_stock
    {}.merge(pig_stock)
      .merge(cattle_stock)
      .merge(poultry_stock)
      .merge(wool_stock)
      .merge(horse_stock)
  end

  def pig_stock
    {
      :sows          => :unknown,
      :piglets       => :unknown,
      :boar          => :unknown,
    }
  end

  def cattle_stock
    {
      :cows          => :unknown,
      :calves        => :unknown,
      :oxen          => :unknown, # castrated male cow (trained)
      :bulls         => :unknown,
    }
  end

  def poultry_stock
    {
      :chicken       => :unknown,
      :cock          => :unknown,

      # Geese, Turkeys, Ducks
    }
  end

  def wool_stock
    {
      :sheep         => :unknown,
      :lambs         => :unknown,
      :rams          => :unknown,

      :nannies       => :unknown,
      :billies       => :unknown,
      :wethers       => :unknown, # castrated male goat (trained)
      :kids          => :unknown,
    }
  end

  def horse_stock
    {
      :draft_horses  => :unknown, # work horses
      :hackneys      => :unknown, # traveling/pack horses
      :palfreys      => :unknown, # traveling horses
      :chargers      => :unknown, # war horses
    }
  end

  def seed_stock
    {
      :rye    => :unknown,
      :oats   => :unknown,
      :wheat  => :unknown,
      :hay    => :unknown,
      :flax   => :unknown,
      :hemp   => :unknown,
      :corn   => :unknown,
      :pulses => :unknown,
    }
  end

  def house_stock
    {
      :firewood   => :unknown,
      :herbs      => :unknown,
      :vegetables => :unknown,
      :fruit      => :unknown,
    }
  end

  def raw_stock
    {
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
    }
  end

  def intermediary_goods
    {
      :milk   => :unknown,
      :pork   => :unknown,
      :beef   => :unknown,
      :mutton => :unknown,
      :eggs   => :unknown,
      :honey  => :unknown,
    }
  end

  def secondary_goods
    {
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
  end
end
