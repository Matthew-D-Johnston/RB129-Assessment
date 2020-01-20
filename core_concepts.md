# RB129 Assessment Preparation

### RB120 Core Concepts

---

##### Object Oriented Programming, or OOP

OOP is a programming paradigm that helps programmers handle the complexity of large software systems.    The paradigm was developed precisely because the growth in size and complexity of applications was becoming very difficult for programmers to maintain. Software applications were becoming massive blobs of dependency so that a slight change in a program could trigger a ripple effect of errors throughout the rest of the program. This problem is the kind of problem one might find in the procedural programming paradigm.

OOP is a useful paradigm for reducing the complexity of software systems because it allows programmers to essentially create containers for data that can be changed and manipulated without affecting the entire program. Rather one massive blob of dependency, OOP allows software programs to be written in a way that dependencies are isolated to the separate containers; those containers are then made to interact with each other. This is where the "Object" part of "Object Oriented Programming" comes in. The whole paradigm is based on the concept of "objects", which contain unique data, and procedures (i.e. methods) used to interact with the objects and their respective data.

Another benefit of the OOP paradigm is that it allows programmers to think on a new level of abstraction. Classes can define an essence inhering to each object, while objects can represent real-world nouns and be given methods that describe the behaviour the programmer is trying to represent.

---

##### Class vs. Object

Classes and objects in Ruby are closely related concepts, but they are not the same. Classes can be thought of as the mold out of which objects are created; or, classes can be thought of as basic outlines of what an object should be made of and what it should be able to do. An object is, therefore, an _instance_ of a class, and all of the attributes and behaviour defined in the class will belong to each object in the form of instance variables and instance methods. 

Each object, however, will have a unique state, comprised of the totality of the object's instance variables and the values to which they are assigned. The object's state tracks the attributes defined in the class and the class's inheritance hierarchy, supplying the object with a unique instance variable corresponding to each attribute, regardless of whether the instance variable has been initialized or not. There is also a set of instance methods that belong to the object as outlined by the behaviours defined within the object's class and the rest of the class's inheritance hierarchy.

Here is a very simple example of class definition and object instantiation.

```ruby
class Dog
end

dog1 = Dog.new
dog2 = Dog.new
```

As a way to confirm that these are indeed unique 'Dog' objects we can compare the two using the `==` operator.  

```ruby
dog1 == dog2
# => false
```







---

##### State vs. Behaviour



---

##### Encapsulation

- hiding pieces of functionality and making it unavailable to the rest of the code base.
- form of data protection, so that data cannot be manipulated or changed without obvious intention.
- defines the boundaries in your application and allows your code to achieve new levels of complexity.

One of the goals of an Object Oriented Problem paradigm is to reduce the amount of dependency within software programs. One of the ways OOP reduces dependecy is through encapsulation. Encapsulation allows programmers to hide pieces of functionality, making those pieces of functionality unavailable to the rest of the code base. It's a form of data protection, preventing data from being changed unintentionally.

Consider what happens in a procedural programming paradigm if we initialize a local variable, say `name`.

```ruby
name = "Matt"
```

Any time we invoke the `name` local variable it should return the value that we have assigned to it.

```ruby
name
# => "Matt"
```

We can also reassign that local variable to a new value.

```ruby
name = "Matthew"
name
# => "Matthew"
```

We might say that the ability to expose and change the value of the local variable is inherent to the nature of what it means to be a local variable. We cannot assign a local variable to a value without also supplying that local variable with the functionality of being able to be exposed and changed.

But encapsulation within the OOP paradigm is precisely the ability to hide that functionality--to make our `name` variable private in a certain sense.  

Suppose we define a class called `Person`...

```ruby
class Person
  def initialize(name)
    @name = name
  end
end
```

And then instantiate a new object from that class...

```ruby
person1 = Person.new("Matt")
```

We have just created a new 'Person' object and assigned it to the local variable `person1`. By passing the 'String' object "Matt" in the `new` method when we instantiated our object, we effectively assigned that value to an `@name` instance variable. But currently, we have no way of directly accessing that instance variable nor the data to which it is assigned.  We can know that it's there by invoking our `person1` local variable.

```ruby
person1
# => #<Person:0x00007f8c21807758 @name="Matt">
```

However, we have no direct way of exposing it or changing it. That's encapsulation. The data is encapsulated within the object. If we want to access the `@name` instance variable, we would have to redefine our  `Person` class in order to give it that special access, which we could do by adding either a getter method or a setter method, or both.

```ruby
class Person
  def intitialize(name)
    @name = name
  end
  
  def name
    @name
  end
  
  def name=(name)
    @name = name
  end
end
```

Or, using Ruby's built-in getter and setter accessor methods, `attr_reader` and `attr_writer`, respectively...

```ruby
class Person
  attr_reader: name
  attr_writer: name
  
  def initialize(name)
    @name = name
  end
end
```

Or, even more efficient, using the `attr_accessor` method, which combines the functionality of both `attr_reader` and `attr_writer`:

```ruby
class Person
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
end
```



---

##### Polymorphism

- the ability for data to be represented as many different types.
- "Poly" stands for "many" and "morph" stands for "forms".
- flexibility of using pre-written code for new purposes.
- types of polymorphism: 1) inheritance; 2) modules; 3) duck-typing.

Polymorphism derives from the Greek roots "poly", meaning "many", and "morphe", meaning "form". Thus, polymorphism literally means "many forms". Within the context of Object Oriented Programming, the concept describes the ability for data to be represented as many different types. It allows programmers the flexibility of using pre-written code for new purposes. 

In the Ruby programming language, we encounter three main ways of implementing polymorphism, or polymorphic structure in our code: 1) inheritance; 2) modules; and 3) duck-typing.

---

##### Inheritance

- one way to apply polymorphic structure in Ruby.
- when a class inherits behaviours of another class, referred to as the superclass.
- gives programmers the power to define basic classes with large reusability and smaller subclasses for more fine-grained, detailed behaviours.

Inheritance is one way of applying polymorphic structure in Ruby. But before we go into explaining how that works, let's explain what we mean by inheritance. Similar to how a child may inherit certain traits from their parents, perhaps even behaviours, Ruby classes can inherit traits and behaviours from other classes. If a class is inherits from another class, it is called a "child class" or a "subclass", while the class from which the child class is inheriting, or subclassing, is called the "parent class" or "super class". 

To illustrate how this is done, we'll use a very simple example.

```ruby
class Parent
end

class Child < Parent
end
```

First, we define a class called `Parent` and then we define a class called `Child` and make it inherit from the `Parent` class using the `<` symbol followed by the name of our `Parent` class. This now means that `Parent` is the superclass from which the `Child` class inherits.  

However, this is not a very interesting example since there is nothing withidn the `Parent` class to inherit. Let's add an `initialize` method to our `Parent` superclass and define that method with a `name` parameter.  

```ruby
class Parent
  def initialize(name)
    @name = name
  end
end

class Child < Parent
end
```

Despite our `Child` class not being explicitly defined with an `initialize` method, we will have to supply an argument to the `new` method whenever we instantiate a new 'Child' object, because we are inheriting the `initialize` method from the `Parent` class. Let's see this at work.

```ruby
child = Child.new("Buzz")
```

Above, we have instantiated a new 'Child' object and assign it to the variable `child`; notice that we passed in the `"Buzz"` argument. We now have our `child` object with an instance variable `@name` that references the 'String' object `"Buzz"`.

Now that we have that straight, let's return to the question of how inheritance allows us to apply polymorphic structure.

```ruby
class Parent
  def initialize(name)
    @name = name
  end
  
  def walk
    puts "I'm going for a nice leisurely walk."
  end
end

class Teenager < Parent
  def walk
    puts "Walk?! I don't want to for a walk. I want to stay at home and play video games."
  end
end

class Infant < Parent
  def walk
    puts "I can't walk. I'm just an infant."
  end
end
```

By inheriting from the `Parent` class, both the `Teenager` class and the `Infant` class benefit from the ability to use the prewritten code of the `initialize` method defined in the `Parent` class; however, inheritence also gives our two subclasses the flexibility to define their own 'drive' behaviour. Let's see this in action.

```ruby
teenager = Teenager.new("Jimmy")
infant = Infant.new("Suzy")

teenager.walk
infant.walk

# => Walk?! I don't want to for a walk. I want to stay at home and play video games.
# => I can't walk. I'm just an infant.
```

Each object has their own implementation of the `drive` method. We we're able to accomplish this despite inheriting the `Parent` classe's behaviour. Inheritance still allows us the flexibility to override the functionality of any behaviour defined in the superclass. We are able to call a `drive` method on instances of two distinct classes and have those methods perform different functions. That's polymorphism.

---

##### Modules

- one way to apply polymorphic structure in Ruby.
- similar to classes in that they contain shared behaviour.
- however, you cannot create an object with a module.
- module must be mixed in with a class using the `include` method invocation (this is called a mixin).
- after mixing in a module, the behaviours declared in that module are available to the class and its objects.

Using modules is another way to apply polymorphic structure in Ruby. But first, let's explain what a module is and does. A module allows us to group common behaviour. There are two main uses for modules: 1) grouping common behaviours; and 2) namespacing. We'll discuss the begin with the first use and treat the second one later.  

Modules are similar to classes in that they allow programmers to group common behaviour in one place and allow it to be shared by different classes and ultimately used to perform functions by different objects; however, unlike classes, no object can be instantiated from a module. For example. 

```ruby
module GaGaAble
  def talk
    puts "Gaah, gaah. Gooh, gooh."
  end
end
```

Here we have defined an `GaGaAble` module that defines a `talk` method. First notice what happens when we try to instantiate an object from this module.

```ruby
GaGaAble.new
# => NoMethodError: undefined method `new' for GaGaAble:Module
```

We get an error message that indicates the `new` method is undefined for our `GaGaAble` module, which is the case for all modules. So, what's the point of a module then if we cannot instantiate objects from it?  

The answer is that a module allows us to group common behaviours that can then be shared by classes. We can enable this sharing via a mixin, which is done whenever we include a module in a class using the `include` keyword. Using our example from above, let's mixin the `GaGaAble` module to our `Infant` class.

```ruby
class Infant < Parent
  include GaGaAble
  
  def walk
    puts "I can't walk. I'm just an infant."
  end
end
```

Now, a `talk` instance method will be available to any object of the `Infant` class.

```ruby
suzy = Infant.("Suzy")
suzy.talk
# => Gaah, gaah. Gooh, gooh.
```

But why didn't we just define a `talk` behaviour directly in the `Infant` class? The key is that by putting that `talk` behaviour in a module we can easily reuse that behaviour for other classes, say for example, a `Toddler` class.

```ruby
class Toddler < Parent
  include GaGaAble
  
  def walk
    "I'm crawling."
  end
end
```

Instead of defining the same `talk` behaviour in both the `Infant` class and `Toddler` class, we can define it once within the `GaGaAble` module.  

From here, we can easily demonstrate how modules can be used to employ polymorphic structure. Suppose we had a `talk` behaviour defined in our `Parent` class like the following.

```ruby
class Parent
  def initialize(name)
    @name = name
  end
  
  def walk
    puts "I'm going for a nice leisurely walk."
  end
  
  def talk
    puts "I'm talking."
  end
end
```

If our `Teenager`, `Infant`, and `Toddler` subclasses all inherit from our `Parent` superclass, then they would all inherit this `talk` behaviour. However, because we have mixed in our `GaGaAble` module to the `Infant` and `Toddler` subclasses, the `talk` behaviour from the `Parent` superclass, while inherited by our `Teenager` class, it will be overridden by the `talk` behaviour from our `GaGaAble` module.  

We know this because if we were to check the method lookup path using the `ancestors` method we will find that whenever the `talk` method is invoked on either an 'Infant' or 'Toddler' object, the first place the method will be looked for is within the classes of those two objects, then any modules that have been mixed in, and then the rest of the classes and modules within the inheritance hierarchy.

```ruby
Infant.ancestors
# => [Infant, GaGaAble, Parent, Object, Kernel, BasicObject]
Toddler.ancestors
# => [Toddler, GaGaAble, Parent, Object, Kernel, BasicObject] 
```

Since the `GaGaAble` module will be searched before the `Parent` class, we know that both objects of either the `Infant` or `Toddler` classes will have a different implementation for the `talk` method than both objects of the `Teenager` class and the `Parent` class; note that the `Teenager` class inherits the `talk` behaviour from the `Parent` class.

```ruby
suzy = Infant.new("Suzy")
jimmy = Teenage.new("Jimmy")

suzy.talk
jimmy.talk
# => Gaah, gaah. Gooh, gooh.
# => I'm talking.
```

Once again, we have a method that functions differently depending on what object that method is called. In this instance, we were able to implement that polymorphic structure using a module.

The other thing to note about modules and mixins compared to classes and inheritance is that we can mixin as many modules as we want to a class, but we can only subclass from a single superclass. Modules are Ruby's way of implementing multliple inheritance. 

Now, I mentioned that there is another use for modules--namespacing. Rather than grouping common behaviours together, we might want to group related classes together. Modules allow us to do that, which is a form of namespacing.

```ruby
module Family
  class Parent
    def initialize(name)
      @name = name
    end

    def walk
      puts "I'm going for a nice leisurely walk."
    end

    def talk
      puts "I'm talking."
    end
  end

  module GaGaAble
    def talk
      puts "Gaah, gaah. Gooh, gooh."
    end
  end

  class Teenager < Parent
    def walk
      puts "Walk?! I don't want to for a walk. I want to stay at home and play video games."
    end
  end
  
  class Infant < Parent
    include GaGaAble

    def walk
      puts "I can't walk. I'm just an infant."
    end
  end

  class Toddler < Parent
    include GaGaAble

    def walk
      "I'm crawling."
    end
  end
end
```

In order to instantiate a new object from any of our classes nested within the `Family` module, we will now have to prefix the class name with the module name (`Family`) and the scope resolution operator (`::`) like so...

```ruby
suzy = Family::Infant.new("suzy")
```

---

#####Duck-Typing

Duck-typing is another way to implement polymorphic structure in Ruby. The easiest way to introduce the concept is with the phrase, "If it walks like a duck and quacks like a duck, it must be a duck!" This means that we can create programs that will deal with different objects, performing similar functions on them but have them respond in different ways.

Let's take the classes that we defined above and let's define a leisure activity appropriate for each class.

```ruby
class Parent
  def initialize(name)
    @name = name
  end

  def walk
    puts "I'm going for a nice leisurely walk."
  end

  def talk
    puts "I'm talking."
  end

  def play_scrabble
    puts "I'm #{@name} and I like to play Scrabble."
  end
end

module GaGaAble
  def talk
    puts "Gaah, gaah. Gooh, gooh."
  end
end

class Teenager < Parent
  def walk
    puts "Walk?! I don't want to for a walk. I want to stay at home and play video games."
  end

  def play_video_games
    puts "I'm #{@name} and I like to play video games."
  end
end

class Infant < Parent
  include GaGaAble

  def walk
    puts "I can't walk. I'm just an infant."
  end

  def play
    puts "I'm #{@name} and I don't play. I like to sleep and eat."
  end
end

class Toddler < Parent
  include GaGaAble

  def walk
    "I'm crawling."
  end

  def play_jolly_jumper
    puts "I'm #{@name} and I like to play in my Jolly Jumper."
  end
end
```



Based on our examples above, let's ignore the `Family` module we created and define a `Family` class with a single behaviour. That behaviour will be `do_leisure_activity` and will be defined with a single parameter that takes an Array object as an argument.

```ruby
class Family
  def do_leisure_activity(family_members)
    family_members.each do |member|
      case member.class.to_s
      when 'Parent' then member.play_scrabble
      when 'Teenager' then member.play_video_games
      when 'Toddler' then member.play_jolly_jumper
      when 'Infant' then member.play
      end
    end
  end
end
```

Now let's create some family members and store them as elements in an array assigned to the local variable called `family`.

```ruby
suzy = Infant.new("Suzy")
jimmy = Teenager.new("Jimmy")
billy = Toddler.new("Billy")
peggy = Parent.new("Peggy")

family = [peggy, jimmy, billy, suzy]
```

Now let's try out our new `do_leisure_activity` method. But remember, we have to call this method on a an object of the `Family` class. So...

```ruby
Family.new.do_leisure_activity(family)
# => I'm Peggy and I like to play Scrabble.
# => I'm Jimmy and I like to play video games.
# => I'm Billy and I like to play in my Jolly Jumper.
# => I'm Suzy and I don't play. I like to sleep and eat.
```

That example was precisely not duck typing but illustrates how duck typing might come in handy. We might economize on our `do_leisure_activity` method if we didn't have to make a separate case for each family member. Suppose we took each of the separately defined 'play' methods in each class just named that behaviour `leisure_activity`. Like this.

```ruby
class Parent
  def initialize(name)
    @name = name
  end

  def walk
    puts "I'm going for a nice leisurely walk."
  end

  def talk
    puts "I'm talking."
  end

  def leisure_activity
    puts "I'm #{@name} and I like to play Scrabble."
  end
end

module GaGaAble
  def talk
    puts "Gaah, gaah. Gooh, gooh."
  end
end

class Teenager < Parent
  def walk
    puts "Walk?! I don't want to for a walk. I want to stay at home and play video games."
  end

  def leisure_activity
    puts "I'm #{@name} and I like to play video games."
  end
end

class Infant < Parent
  include GaGaAble

  def walk
    puts "I can't walk. I'm just an infant."
  end

  def leisure_activity
    puts "I'm #{@name} and I don't play. I like to sleep and eat."
  end
end

class Toddler < Parent
  include GaGaAble

  def walk
    "I'm crawling."
  end

  def leisure_activity
    puts "I'm #{@name} and I like to play in my Jolly Jumper."
  end
end
```

Then, we could redefine our the `do_leisure_activity` behaviour in our `Family` class in the following way.

```ruby
class Family
  def do_leisure_activity(family_members)
    family_members.each do |member|
      member.leisure_activity
    end
  end
end
```

Now, if we invoke a `do_leisure_activity` instance method on a newly instantiated Family object, we get the following...

```ruby
Family.new.do_leisure_activity(family)
# => I'm Peggy and I like to play Scrabble.
# => I'm Jimmy and I like to play video games.
# => I'm Billy and I like to play in my Jolly Jumper.
# => I'm Suzy and I don't play. I like to sleep and eat.
```

We get the same output, but our `do_leisure_activity` behaviour is defined much more simply and it is ultimately more flexible, as we could essentially run it with any object as an element of the array so long as the object in question has an instance method called `leisure_activity`.

---

`self`

* Two main uses: 1) disambiguate from creating a local variable; and 2) defining a class method.



We use `self ` to specify a certain scope within our program, which means that `self` can refer to different things depending on where it is used. `self` is a way of being explicit about what our program is referencing and what our intentions are as far as behaviour.

One of the main contexts where we will find `self` being used then is within an instance method defintion that is within the class definition, where it is being used to disambiguate from a local variable. This is mostly used in the context of calling a setter method where we want to disambiguate from initializing a local variable. When we use `self` in this manner within an instance method, `self` is returning the calling object. That means whatever object we are calling the instance method on, `self` will refer to that very same object.  

As an example, let's take our `Parent` class definition. 

```ruby
class Parent
  def initialize(name)
    @name = name
  end

  def walk
    puts "I'm going for a nice leisurely walk."
  end

  def talk
    puts "I'm talking."
  end

  def leisure_activity
    puts "I'm #{@name} and I like to play Scrabble."
  end
end
```

Notice that for our `leisure_activity` behaviour we use string interpolation to reference our 'name' attribute. Let's introduce a getter method that we can reference in the string interpolation rather than the `@name` instance variable. While we're at it, let's add a setter method as well, because we want to illustrate the importance of using `self` to disambiguate from initializing a local variabe whenever we use a setter method within an instance method definition. Thus, we'll add an `attr_accessor` that will suppy us with both a getter and setter method for our 'name' attribute.

```ruby
class Parent
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end

	# ... rest of code omitted for brevity.

  def leisure_activity
    puts "I'm #{name} and I like to play Scrabble."
  end
end
```

Notice the two changes: 1) addition of the `attr_accessor` method; and 2) the replacement of `@name` with `name` in `leisure_activity`. So, if we call `leisure_activity` on our `peggy` Parent object initialized earlier, we should get the same output as if we were still referencing the `@name` instance variable rather than the `name` getter method.

```ruby
peggy.leisure_activity
# => "I'm Peggy and I like to play Scrabble."
```

Notice also that we could have also prepended `name` in the string interpolation with `self` and we would get the same result.

```ruby
class Parent
	# ... rest of code omitted for brevity.

  def leisure_activity
    puts "I'm #{self.name} and I like to play Scrabble."
  end
end

peggy.leisure_activity
# => "I'm Peggy and I like to play Scrabble."
```

However, in this case the `self` is unnecessary, and we should avoid using it whenever it is unnecessary.

But let's say we want to define an `add_last_name` behaviour that will append a String representation of a last name to the `@name` intance variable.

```ruby
class Parent
	# ... rest of code omitted for brevity.

  def add_last_name(last_name)
    name += " #{last_name}"
  end
end
```

But when we try to invoke this method on our `peggy` object we get an error.

```ruby
peggy.add_last_name("Jones")
# => NoMethodError: undefined method `+' for nil:NilClass
```

This is because Ruby thinks `name` within our method definition is a local variable, and one that we have not yet initialized. That is why Ruby won't allow us to perform `+`, because the local variable is returning `nil` and `+` is an undefined method within the `NilClass`. In order to disambiguate between `name` as a local variable and our `name` setter method, we need to prepend it with `self`.

```ruby
class Parent
	# ... rest of code omitted for brevity.

  def add_last_name(last_name)
    self.name += " #{last_name}"
  end
end
```

Now, we can call our `add_last_name` method and then invoke the `name` getter method on `peggy` to see the updated name change.

```ruby
peggy.add_last_name("Jones")
peggy.name
# => "Peggy Jones"
```

The other main context where we find `self` being used is whenever we are defining a class method. Class methods define behaviour for the class, rather than instances of the class. In order to define a class method, we must prepend the name of the method with `self`. In this context, `self` references the class. Here's an example with our `Parent` class.

```ruby
class Parent
	# ... rest of code omitted for brevity.

	def self.what_i_am
    puts "I'm a parent!!!"
  end
end
```

In order to use this method we must call it on the class itself.

```ruby
Parent.what_i_am
# => I'm a parent!!!
```

---

`public`, `private`, and `protected`

