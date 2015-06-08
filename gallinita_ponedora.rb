class LayingHen

  def initialize
    @hen_age = 0
    @eggs = []
    @number_of_eggs = @eggs.length

  end

  # Ages the hen one month, and lays 4 eggs if the hen is older than 3 months
  def age!
    @hen_age += 1
    4.times do
      if @hen_age > 3
        @eggs << Egg.new
        @number_of_eggs += 1
      end
    end
  end
  def age
    @hen_age 
  end
  # Returns +true+ if the hen has laid any eggs, +false+ otherwise
  def any_eggs?
    @number_of_eggs > 0 ? true : false

  end

  # Returns an Egg if there are any
  # Raises a NoEggsError otherwise
  def pick_an_egg!
    raise NoEggsError, "The hen has not layed any eggs" unless self.any_eggs?

    # egg-picking logic goes here
    if @eggs.length > 0
      egg = @eggs.pop
      @number_of_eggs -= 1
    end
    egg
  end

  # Returns +true+ if the hen can't laid eggs anymore because of its age, +false+ otherwise
  def old?
    @hen_age > 10 ? true : false
  end

  def increase_hatched_hour(hours)
    @eggs.each do |each_egg|
      each_egg.hatched_egg += hours
      # time.hatched_egg = time.hatched_egg + hours
    end
  end
end

class Egg
  attr_accessor :hatched_egg

  # Initializes a new Egg with hatched hours +hatched_hours+
  def initialize
    @hatched_egg = 0
  end

  # Return +true+ if hatched hours is greater than 3, +false+ otherwise
  def rotten?
    @hatched_egg > 3 ? true : false
  end
end


hen = LayingHen.new
basket = []
rotten_eggs = 0

hen.age! until hen.any_eggs?

puts "Hen is #{hen.age} months old, its starting to laid eggs."
puts ""

until hen.old?

  # The time we take to pick up the eggs
  hours = rand(5)
  hen.increase_hatched_hour(hours)

  while hen.any_eggs?
    egg = hen.pick_an_egg!

    if egg.rotten?
      rotten_eggs += 1
    else
      basket << egg
    end
  end

  puts "Month #{hen.age} Report"
  puts "We took #{hours} hour(s) to pick the eggs"
  puts "Eggs in the basket: #{basket.size}"
  puts "Rotten eggs: #{rotten_eggs}"
  puts ""

  # Age the hen another month
  hen.age!
end

puts "The hen is old, she can't laid more eggs!"
puts "The hen laid #{basket.size + rotten_eggs} eggs"
if rotten_eggs == 0
  puts "CONGRATULATIONS NO ROTTEN EGGS" 
else
  puts "We pick too late #{rotten_eggs} eggs, so they become rotten"
end