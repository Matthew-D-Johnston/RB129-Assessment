# RB129 Assessment Preparation

### RB120 Core Concepts

---

##### Object Oriented Programming, or OOP

OOP is a programming paradigm that helps programmers handle the complexity of large software systems.    The paradigm was developed precisely because the growth in size and complexity of applications was becoming very difficult for programmers to maintain. Software applications were becoming massive blobs of dependency so that a slight change in a program could trigger a ripple effect of errors throughout the rest of the program.

OOP is a useful paradigm for reducing the complexity of software systems because it allows programmers to essentially create containers for data that can be changed and manipulated without affecting the entire program. Rather one massive blob of dependency, OOP allows software programs to be written in a way that dependencies are isolated to the separate containers; those containers are then made to interact with each other. This is where the "Object" part of "Object Oriented Programming" comes in. The whole paradigm is based on the concept of "objects", which contain unique data, and procedures (i.e. methods) used to interact with the objects and their respective data.

---

##### Class vs. Object

Classes and objects in Ruby are closely related concepts, but they are not the same. Classes can be thought of as the mold out of which objects are created; or, classes can be thought of as basic outlines of what an object should be made of and what it should be able to do. An object is, therefore, an instance of a class, and all of the attributes and behaviour of an object are defined within the object's class. Each object, however, will have a unique state, which tracks the attributes for individual objects.



Ruby defines the attributes and behaviors of its objects in **classes**. You can think of classes as basic outlines of what an object should be made of and what it should be able to do.

States track attributes for individual objects. Behaviors are what objects are capable of doing.



If, as the Object Oriented Programming book says, "Ruby defines the attributes and behaviors of its objects in classes," are attributes inherited by a subclass from a superclass? Or is only behaviour inherited when we use subclass from another class?



#### Classes and Objects in Ruby: a Purely Platonic Relationship

Classes and objects in Ruby are intimately related, but it's more of a spiritual relation than it is physical. It helps to have Plato's Theory of Forms in mind when thinking about classes and objects in Ruby. Classes are universal forms and objects are particular objects. That's about as far as I want to push the analogy, since I'm more concerned about the specific relationship between classes and objects in Ruby than I am about Plato's philosophy at the moment. But hopefully that helps to fix your mind in just the right kind of way that the following discussion will glide more swiftly through your brain's neural pathways.

Classes define an essence that predetermines objects; that is, a class defines the behaviours and attributes that will pertain to any particular object of that class. Both behaviours and attributes are defined within a class, but before any object is created, or instantiated, the behaviours and attributes exist only _in potentia_; that is, they exist as formal essential possibilities rather than as substantive particular realities. And in this case, contra the existentialists, _essence precedes existence_. 

In the example below, we define a `Robot` class, which represents the essence of what it is to be a Robot. In the simple case that we have defined above, a Robot has the ability to 'talk' and has a 'name' attribute. 

```ruby
# Class Definition -- Formal Essence

class Robot
  def initialize(name)
    @name = name   								# Here, we define an attribute within the class.
  end
  
  def talk												# Here, we define a behaviour within the class.
    puts "I'm a robot, and I can talk."
  end
end 
```

With this `Robot` class defined, we are now able to instantiate any number of Robot objects. We take our formal essence of what it is to be a Robot and give it substantive existence by creating particular robots. Here are a few possibilities.

```ruby
# Object Instantiation -- Particular Existence

r2d2 = Robot.new("R2D2")
c3p0 = Robot.new("C3P0")
alexa = Robot.new("Alexa")
```

It's often helpful to think about what something isn't and what it can't do in order to better understand what it is and what it can do. In regards to Ruby objects and behaviour, objects cannot behave in ways that are not predefined within the class or the classes' inheritance hierarchy (including any behaviours pertaining to modules that have been _mixed in_). For instance, because we have not defined the behaviour 'walk' in our `Robot` class, we will get an error when we try to invoke a `walk` instance method on one of our objects.

```ruby
r2d2.walk
# => NoMethodError: undefined method `walk' for #<Robot:0x00007fc0590c9970 @name="R2D2">
```

Instance methods _expose_ (in a purely Platonic sense) for objects  the behaviours of a class; that is, they show precisely what the object is capable of doing by getting the object to do it. By invoking the `talk` method on one of our Robot objects, we are exposed to the behaviour 'talk', which has been defined in our `Robot` class.

```ruby
r2d2.talk
# => I'm a robot, and I can talk.
```

So much for behaviour and the instance methods that expose it. What about attributes? Attributes are a somewhat thornier issue, as we'll see. First, let's think about what an object isn't, or perhaps, what it means for an object not to have certain existential qualities. 

An object cannot have a _specific instance_ of any _attribute_ that is not already predefined in the class or the classes' inheritance hierarchy. And this is important: attributes are predefined in the class, but the instance of any attribute can only take on substantive form when initialized either upon the instantiation of a specific object or when a setter method is invoked on an object; those instances, are aptly named _instance variables_. 

Instance variables are a kind of descendant of attributes, but are separate from them. Attributes are defined in the class; instance variables exist as part of an object's state, and are used to keep track of that state. An object's state tracks the attributes defined within the class; that is, the attributes are the formal essence that predetermine the possibilities of any object's state, while the instance variables are the instances that give substance to the state. State does not exist, even in a formal sense, prior to the instantiation of any object. But once an object is created, or instantiated, the object's state appears and becomes like an intermediary between the attributes defined in a class and the instance variables pertaining to an object. To be sure, states pertain to and are unique to objects, but they are the portal between classes and objects through which attributes flow. Let's explore this in more depth with some concrete examples.

All of the attributes in a class are what prefigures objects and their respective states. In our `Robot` class, we have only one attribute. Thus, the state of any Robot object will only track a single attribute--'name'. But remember, attributes only exist in a formal sense. They are a part of the essence defined by the `Robot` class. The substantive existence of attributes are instance variables. In this case, the substantive existence of the 'name' attribute is the  `@name` instance variable. We can see that one of our Robot objects have the `@name` instance variable by invoking the `p` method on one of those objects.

```ruby
p c3p0
# => #<Robot:0x00007fc059192e60 @name="C3P0">
```

As you can see the return value contains the class name (`Robot`), an encoding of the object's id (`0x00007fc059192e60`), and the `@name` instance variable, which is assigned the value `"C3P0"`. Thus, we can say that our object's state is currently comprised of a single instance variable and the value with which that instance variable is associated.

What is interesting about this instance variable, however, is that we have no direct access to it. It is encapsulated within the object and thus protected from any unwanted behaviour that might expose or affect it. Encapsulation, of course, is one of the goals of the Object Oriented Programming paradigm, as a form of data protection. Suppose we want to have more direct access to our `@name` instance variable. We could try calling a `name` method on one of our Robot objects. However, an error would be returned.

```ruby
c3p0.name
# => NoMethodError: undefined method `name' for #<Robot:0x00007fc059192e60 @name="C3P0">
```

Thus, in order to directly expose the `@name` instance variable, we will need to define a _getter_ method.

```ruby
class Robot
  # ... rest of code omitted for brevity
  
  def name
    @name
  end
end
```

When we call the `name` getter method, we get what we want--direct exposure to our `@name` instance variable. The value of that instance variable is returned. We might even say that we have been given some exposure to the object's current _state_.

```ruby
c3p0.name
# => "C3P0"
```

Now suppose we wanted to change the value associated with our `@name` instance variable. We might try the following to assign a new value to the `@name` instance variable in the following way.

```ruby
c3p0.name = "Buzz"
# => NoMethodError: undefined method `name=' for #<Robot:0x00007fc059192e60 @name="C3P0">
```

However, once again we get an error because we tried to invoke a _setter_ method that has yet to be defined. Let's define it.

```ruby
class Robot
  # ... rest of code omitted for brevity
  
  def name=(name)
    @name
  end
end
```

Now, let's try to reassign our `@name` instance variable again by invoking the newly defined `name=` setter method.

```ruby
c3p0.name = "Buzz"
c3p0.name
# => "Buzz"
```

Success! We changed the value of our `@name` instance variable to `"Buzz"` on the first line with our `name=` setter method, and on the second line we invoke our `name` getter method to expose the new value of our `@name` instance variable. In this example, we have changed the state of our Robot object. Remember, instance variables keep track of an object's state. By changing the value associated with an instance variable, we are effectively changing the object's state in a very substantive way.

But there is a more nuanced issue at stake when we introduce getter and setter methods that expose and affect our object's state. Typically, because getter and setter methods are indeed methods, we think of them as being associated with behaviour, rather than attributes themselves. However, there is some overlap between behaviour and attributes in that attributes can actually encompass certain behaviours. 

For instance, our `Robot` class defines a 'name' attribute, but what exactly is an attribute? What are the properties of an attribute? Is it not possible that for our 'name' attribute, part of its existence as an attribute is the ability to be exposed or changed?

Before we defined our `name` getter method and `name=` setter method above, the sole property inherent to our 'name' attribute was that it predetermined the object's state in a way that makes it possible that a `@name` instance variable would be initialized on instantiation of every object. The 'name' attribute was somewhat restricted in a certain sense. Of course, we can also think of initialization as a behaviour, one that is associated with the `initialize` method. Thus, attributes and behaviours are not so distinct, but are intimately connected. After we define our getter and setter methods, we can now add the properties of the ability to be exposed and the ability to be changed to our 'name' attribute. In this way, our getter and setter methods may also be thought of as attributes, or at least as contingent properties of the overall 'name' attribute.

It might be helpful to see these ideas in action with a bit of code. Since getter and setter methods are so common, Ruby has a built in way of defining them within a class. For the getter method, we have `attr_reader`; for the setter method, we have `attr_writer`; and if we want both a getter and setter method, we have `attr_accessor`. Each of these methods take a Symbol object as an argument.

Let's utilize the `attr_accessor` getter/setter method in our `Robot` class. The argument that we will pass to this method will be the Symbol object `:musical`. By defining this method within the `Robot` class, we will at the same time be defining a 'musical' attribute that will predetermine the state of any object that gets instantiated from our `Robot` class. Let's also include an `attr_accessor` method for our 'name' attribute. Here's our new class definiton.

```ruby
class Robot
  attr_accessor :musical		# Here, we define a 'musical' attribute within the class.
  attr_accessor :name				# Here, we define a 'name' attribute within the class.
  													# Note that the two attributes have the behavioural properties
  													# of getting and setting.
  
  def initialize(name) # Here, we are specifiying an additional property of our 'name'
    @name = name			 # attribute. That additional property is that an `@name` instance 
  end 								 # variable will be initialized upon the instantiation of any object.
  
  def talk				# Here, we define a behaviour within the class.
    puts "I'm a robot, and I can talk."
  end
end 
```

Thus, we now have two attributes pertaining to our `Robot` class and which will be tracked by the state of any object that we instantiate. 

**Note for helping to explain why the accesor methods can be thought of as being inherent to attributes**: Similar to how a local variable returns its value when called and we can easily reassign it to another value, we just take it for granted that those behaviours inhere with the local variable itself. We don't need to define separate methods in order for us to return the value of the variable nor reassign it to another value. 

However, when we get to object oriented programming we are all of a sudden confronted with a situation where we can no longer take that for granted. OOP allows us to define attributes within a class that do not have those behaviours. This flexibility is part of what we know as encapsulation. However, we can also define the attribute with those behaviours. So, with getter and setter accessor methods, we treat them as attributes themselves, rather than separate behaviours.

It's time that we think about this idea of an object's state tracking the attributes defined in a class a little more deeply. First of all, let's go through object instantiation again.

```ruby
alexa = Robot.new("Alexa")
```

Let's now call the `p` method on our newly instantiated `alexa` Robot object.

```ruby
p alexa
# => #<Robot:0x00007fc7a30ce398 @name="Alexa"> 
```

That's interesting. Only the `@name` instance variable is present in the return value; there is no sign of an `@musical` instance variable. Of course, that is because it hasn't been initialized yet, and it may be tempting to think that because it is uninitialized, it cannot keep track of the object's state and even that the 'musical' attribute is not being tracked by the object's state. I would argue, however, that this is incorrect. Instead, if we claim that unitialized instance variables do indeed track their object's state, then I think it helps to understand why the following code returns the value that it does.

```ruby
alexa.musical
# => nil
```

If we were to try to invoke an uninitialized local variable we would get an `NameError: undefined local variable or method` error message. However, in this case of an uninitialized instance variable, we get `nil`.

This suggests that while uninitialized, our object knows about the `@musical` instance variable. It's as if the `@musical` instance variable were existing in some kind of latent state. This is where the idea that an object's state as a kind of intermediary between the object and its class begins to become clearer: the object's state is tracking the 'musical' attribute but the attribute only exists in a formal way and gives shape to the state; the uninitialized `@musical` instance variable is latent, but it is still keeping track of the object's state. Attributes as they pertain to an object's state, take on substantive existence as instance variables with specific values. In this case, the state of the object as it pertains to the 'musical' attribute is 'nil'.

To bring the example to life a little bit, let's suppose that we have a robot named Alexa and Alexa has been created with the potential for musical abilities. Currently, Alexa does not play any instrument, nor does she sing, but she has latent musical abilities that exist _in potentia_. Her musical abilities do not have a positive existence. Her musical abilities are not nothing, as they would be say for a rock, but they do have a kind of null, or nil, existence (to speak of musical abilities of a rock would be to speak nonsense).

But now let's say Alexa starts practicing the guitar. All of a sudden, Alexa's musical abilities have a positive existence--she now has musical abilities. If we were to try to mimic this example with code, we could define a few 'practice' methods pertaining to different musical instruments within our `Robot` class.

```ruby
class Robot
  # ... rest of code omitted for brevity
  
  def practice_guitar
    musical ? self.musical << 'I play guitar' : self.musical = ['I play guitar']
  end
  
  def practice_piano
    musical ? self.musical << 'I play piano' : self.musical = ['I play piano']
  end
  
  def practice_singing
    musical ? self.musical << 'I sing' : self.musical = ['I sing']
  end
end 
```

Let's give `alexa` the musical ability to play the guitar and the piano.

```ruby
alexa.practice_guitar
alexa.practice_piano
puts alexa.musical
# => I play guitar
# => I play piano
```

The state of `alexa` has been transformed as the `@musical` instance variable has been initialized and assigned with new values. Notice that the invocation of the `practice_guitar` causes the initialization of the `@musical` instance variable as the call to the `musical` getter method in the ternary operator returns the `nil` value associated with the `@musical` instance variable, and this falsey value causes the ternary operator to evaluate to `false`, which in turn leads to the `self.musical = ['I play guitar']` section of code being executed instead of the `self.musical << 'I play guitar'` section of code.

However, since the `@musical` instance variable has been initialized, when we invoke the `practice_piano` method on `alexa`, the `musical` getter method returns `["guitar"]`, which is a truthy value and thus the ternary operator evaluates to `true`. That causes the `self.musical << 'I play piano'` section of code to be executed instead of the `self.musical = ['I play piano']` section of code.

Alexa's latent musical abilities have now been realized through praciticing the guitar and the piano. She is still the same robot, but her state has been transformed. 





I want to say one more thing specific to the idea that state's track attributes in order to flesh out why this idea should be emphasized. Consider our `Robot` class. Suppose we add another `attr_accessor` getter/setter method for a 'love' attribute. Notice that we make this change directly in the class itself without doing anything to any of our already existing Robot objects. If the states of our respective objects are indeed tracking the attributes of the class, then then there will exist uninitialized instance variables associated with the 'love' attribute without having invoked any method on any of our objects. Those unitialized local variables are in a latent state, and are already at work, keeping track of the object's state. In this case the unitialized `@love` instance variable is associated with the value `nil`. Our robots have the potential for 'love', but that potential has yet to become a substantive reality.





To sum up. Classes are forms that predetermine the particular objects or instances of the class. The essence of any particular object is defined within the Class. This essence is comprised of behaviours and attributes. When an object is instantiated it endowed with a state, which is prefigured by the attributes of the class and indeed which tracks those attributes.



---









Another aspect of attributes is that they may also encompass certain behaviours, specifically the behaviours of _getting_ or _setting_. ...



State kind of has two sides, two sides of the same coin. For instance, less say I have the potential for musical ability. In a certain sense we could say that musicality is a part of my state. However, until I initialize that musicality with practice of an actual musical instrument it has a kind of null existence within my overall state. I have musical potential, but as yet I am not musical; my musical abilities are _nil_ at this point (emphasis on the word 'nil', and more on this in the next paragraph). This is analgous to an attribute that is defined within a class, but has yet to be given substantive existence through the initialization of the specific instance variable associated with that attribute, but that instance variable can only be initiated if the attribute with which it is associated is tracked by the object's state--that is, only if it is an attribute that is defined within the object's class. 

Now, let's talk about 'nil', or perhaps, `nil`. This is also helpful for understanding why when an uninitialized instance variable is invoked by calling a getter method on our object that what is returned is `nil`. `nil` is that negative existence within the overall state. Thus, the state knows that there is an attribute providing the potential for an instance variable to be initialized, but until it is initialized, it carries that negative existence (a heavy load, no doubt). Thus, the unitialized instance variable exists as part of the object's state, but in a sort of negative way; only once it has been initialized does it exist in a more positive way.



After instantiating a new `Human` object and assigning that object to the variable `matt`, we can now call the `talk` instance method on that object.

```ruby
matt.talk
# => I'm a human, and I can talk.
```

We also are now aware that the object to which `matt` refers encapsulates the instance variable `@name` associated with the value `"Matt"`. We can simply call `p` on our object to see this.

```ruby
p matt
# => #<Human:0x00007f918f81e840 @name="Matt"> 
```







, and an object will not have any attribute that is not 

When attributes, in their concrete form as qualities of objects, are instance variables. 

 the behaviour and attributes of particular objects of that class. Thus the behaviour and attributes are only _in potentia_; that is, they exist as possibilities. Once an object is instantiated, it is endowed with a state, tracking specific values for its attributes (i.e. instance variables). 



But with that in mind, if a `Dog` class inherits from an `Animal` class.

---

##### State vs. Behaviour



---

##### Encapsulation



---

##### Polymorphism



---

##### Inheritance



---

##### Modules



---

##### 

