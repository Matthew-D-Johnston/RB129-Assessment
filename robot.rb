# robot.rb

class Robot
  attr_accessor :musical    # Here, we define a 'musical' attribute within the class.
  attr_accessor :name       # Here, we define a 'name' attribute within the class.
                            # Note that the two attributes have the behavioural properties
                            # of getting and setting.
  
  def initialize(name) # Here, we are specifiying an additional property of our 'name'
    @name = name       # attribute. That additional property is that an `@name` instance 
  end                  # variable will be initialized upon the instantiation of any object.
  
  def talk        # Here, we define a behaviour within the class.
    puts "I'm a robot, and I can talk."
  end

  def practice_guitar
    musical ? self.musical << 'I play guitar' : self.musical = ['I play guitar']
  end
  
  def practice_piano
    musical ? self.musical << 'I play piano' : self.musical = ['I play piano']
  end
  
  def practice_singing
    musical ? self.musical << 'I sing' : self.musical = ['sing']
  end
end

alexa = Robot.new("Alexa")
p alexa
alexa.practice_guitar
alexa.practice_piano
puts alexa.musical

