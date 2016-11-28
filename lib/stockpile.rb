require 'contracts'

class Stockpile
  include Contracts::Core
  include Contracts::Builtin

  attr_accessor :seed_stock
  attr_accessor :reserved_seed_stock
  attr_accessor :harvested_grain

  def initialize
    @seed_stock = 100
    @reserved_seed_stock = 0
    @harvested_grain = 0
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

  Contract Num => Num
  def reserve_seed_stock(amount)
    amount = @seed_stock if @seed_stock <= amount

    @seed_stock -= amount
    @reserved_seed_stock += amount

    return amount
  end

  Contract Num => Bool
  def remove_seed_stock(amount)
    @reserved_seed_stock -= amount

    return true
  end

  Contract Num => Bool
  def unreserve_seed_stock(amount)
    @reserved_seed_stock -= amount
    @seed_stock += amount

    return true
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
      :sows          => :unknown, # 0.40-0.97 swine / 100 acres sown
                                  # 49% used for pork
                                  # 64-72kg of pork
      :piglets       => :unknown,
      :boar          => :unknown,
    }
  end

  def cattle_stock
    {
      :cows          => :unknown, # 6.47-10.61 cattle / 100 acres sown
                                  # 0.55-0.94:1 calf to cow ratio
                                  # 100% used for milk
                                  # 25% used for beef
                                  # 100-151 litres of milk yield
                                  # 168-238kg of beef yield
      :calves        => :unknown, # 14.2% used for veal
                                  # 29-41kg veal per calf
      :oxen          => :unknown, # castrated male cow (trained)
                                  # avg life 4.6-7.5 years
                                  # 4.62-9.62 oxen kept / 100 acres sown
                                  # .85-2.79:1 oxen to horse ratio
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
      :sheep         => :unknown, # 26.18-63.01 sheep / 100 acres sown
                                  # 100% used for wool
                                  # 26% used for mutton
                                  # 1.3-1.8kg wool per sheep
                                  # 22-30kg mutton
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
                                  # avg life 3.7-5.0 years
                                  # 3.4-7.19 horses kept / 100 acres sown
                                  # .85-2.79:1 oxen to horse ratio
      :hackneys      => :unknown, # traveling/pack horses
      :palfreys      => :unknown, # traveling horses
      :chargers      => :unknown, # war horses
    }
  end

  # def seed_stock
  #   {
  #     :wheat  => :unknown, # Sown 2.43-2.56 bushel / acre
  #     :rye    => :unknown, # Sown 2.62-3.02 bushel / acre
  #     :barley => :unknown, # Sown 3.97-4.16 bushel / acre
  #     :oats   => :unknown, # Sown 2.67-3.67 bushel / acre
  #     :pulses => :unknown, # Sown 2.19-2.90 bushel / acre
  #     :hay    => :unknown,
  #     :corn   => :unknown,

  #     :flax   => :unknown,
  #     :hemp   => :unknown,
  #   }
  # end

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

      :wheat  => :unknown, #  8.52-11.27 gross; 5.89-8.71  net (includes 10% tithe)
      :rye    => :unknown, # 12.00-14.65 gross; 9.21-12.04 net (includes 10% tithe)
      :barley => :unknown, # 12.54-14.41 gross; 8.44-10.25 net (includes 10% tithe)
      :oats   => :unknown, #  8.93-11.12 gross; 6.27-7.49  net (includes 10% tithe)
      :pulses => :unknown, #  7.44-8.93  gross; 5.25-6.14  net (includes 10% tithe)
      :hay    => :unknown,
      :corn   => :unknown,

      :flax   => :unknown,
      :hemp   => :unknown,
      :wool   => :unknown, # 1.5-??-2.12 lb per sheep. 24d-30d-42d / stone of wool clip

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
