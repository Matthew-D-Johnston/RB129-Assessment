#### Towards a Conceptual Model of Classes and Objects in Ruby: resolving the problem of "the One and the Many"

How is that we are able to use a term like "dog" and make it applicable to so many different beings in the world? We've got chihuahuas, pugs, poodles, golden retrievers, mastiffs, and the list goes on. Is there some universal essence that allows us to group certain particular beings together into one distinct category? 

This problem of _universals_ and _particulars_, also known as the problem of "the One and the Many", is not a new one. Plato was asking the same question thousands of years ago. He came up with a whole theory about it, a theory we refer to as Plato's Theory of the Forms. Plato, of course, wouldn't have the last word on the matter, and today, computer programmers still grapple with the problem. One solution they have come up with is Object Oriented Programming (OOP). We're going to discuss the OOP paradigm within the context of the Ruby programming language, focussing especially on how to think and talk about Ruby classes and Ruby objects. Consider this an initial attempt from a still nascent computer programmer at trying to conceptualize the relationship between classes and objects.

Let's begin by thinking of Ruby classes as universal forms and Ruby objects as particular beings. A class defines an essence that predetermines or prefigures the particular objects instantiated from that class; more specifically, a class defines the _behaviours_ and _attributes_ (LS, OOP book) that govern what any particular object is capable of doing and the purview of any particular object's _state_ (the italicized words are emphasized because they are semantically loaded terms within the OOP paradigm, at least Ruby's implementation of it).  

Both behaviours and attributes are defined within a class, but before any object is created, or instantiated, the behaviours and attributes exist only _in potentia_; that is, they exist as formal essential possibilities rather than as substantive particular realities. And in this case, contra the existentialists, _essence precedes existence_.  

Below is a visual schema of the relationship between classes and objects. Have a look, but don't get drowned in the details just yet. The rest of our discussion will be concerned with explaining this schema in more detail. Refer back to it as desired.

**[insert class and object diagram here]**

##### Classes and Objects

###### Class (Formal Essence)

As previously mentioned, attributes and behaviours are defined within a class. The combination of these attributes and behaviours comprise the universal essence inhering to every instance, or object, of the class. Just as we might assume that there must be some universal properties inhering within every Chihuahua, St. Bernard, and Pug that enables us to refer to each one of them as a dog, a class is what defines that essence within the context of the Ruby programming language.

Let's start with an example. Below, we define a `Robot` class, in which we outline the essence of what it is to be a Robot object. In the simple case outlined below, a Robot object has the ability to 'talk' (behaviour) and has a 'name' attribute. 

```ruby
# Class Definition -- Formal Essence

class Robot
  def initialize(name) 
    @name = name   		 # Here, we define a 'name' attribute within the class.
  end
  
  def talk						 # Here, we define a 'talk' behaviour within the class.
    puts "I'm a robot, and I can talk."
  end
end 
```

The attribute and behaviour we have defined above within the `Robot` class work to make up the universal essence of every 'Robot' object. Every 'Robot' object instantiated from the `Robot` class will be unique, but it we know it's a 'Robot' because of this universal essence. Currently, that essence consists of a 'name' attribute, which will predetermine that every object of the `Robot` class has an `@name` instance variable, and a 'talk' behaviour, which predetermines that every object of the `Robot` class will have a `talk` instance method.

###### Object (Substantive Existence)  

An object, or instance, is a particular instantiation of a class. For example, we can instantiate one, or any number of 'Robot' objects from our `Robot` class. Below we instantiate two.

```ruby
# Object Instantiation -- Particular Existence

r2d2 = Robot.new("R2D2")
c3p0 = Robot.new("C3P0")
```

Notice that because we defined the `initialize` constructor method with a `name` parameter we must pass an argument to the `new` method when we call it on our `Robot` class in order to instantiate a new Robot object. 

Each of the Robot objects instantiated above are unique, each having its own unique object id, which we can reveal by calling the `object_id` method on each one our objects.

```ruby
r2d2.object_id
# => 70218315657300
c3p0.object_id
# => 70218315588860
```

Upon instantiation, each object also generates its own unique state. By state, we mean the collection of all the instance variables belonging to the object. In the case of our Robot objects above, for each object there is only one instance variable, `@name`. Thus, the collection of the instance variables for each of our Robot objects is accounted for by each object's respective `@name` instance variable.

Instance variables keep track of an object's state (LS OOP book). More precisely, instance variables keep track of information about an object's state (LS OOP book). For instance, the `@name` instance variable belonging to our `r2d2` Robot object references the value `"R2D2"`. This piece of data or information is what comprises the state of an object, and is what the `@name` instance variable is tracking. It is unique from the values associated with the `@name` instance variable belonging to our other Robot object, `c3p0`.

```ruby
p r2d2
# => #<Robot:0x00007fb9f385e0a8 @name="R2D2">
p c3p0
# => #<Robot:0x00007fb9f383c9f8 @name="C3P0">
```

Above, we've called the `p` method on both of our Robot objects, which returns a value containing the name of the class, an encoding of the object id, and the value associated with each object's respective `@name` instance variable. As we can see, each object's respective `@name` instance variable is associated with a different value, evidence that each object has its own unique state. 

Indeed, we can even say that objects encapsulate state (somewhere from LS). For example, we currently have no direct access to the `@name` instance variable and the value it references for any of our Robot objects. We can neither expose it nor manipulate it. It is untouchable, or private. We might try to access it and expose it by doing something like the following...

```ruby
r2d2.name
```

…but instead of the `r2d2` object allowing the value referenced by its `@name` instance variable to be exposed, we get the following error...

```ruby
# => NoMethodError: undefined method `name' for #<Robot:0x00007ff7900f5c28 @name="R2D2">
```

Hmmmm....an undefined method error. Now might be a good time to turn to discussing behaviour and attributes, which are defined within a class and which comprise the formal essence of any particular object.

##### Behaviour, Attributes, and their Corresponding Instances

###### Behaviour and Instance Methods

Behaviours defined in a Ruby class predetermine what any individual object of that class is capable of doing. It's important here to realize that any particular object in question is not strictly limited to the behaviours of its class; it may also perform behaviours defined in any of the superclasses within its inheritance hierarchy as well as any mixed-in modules.  

If we invoke the `ancestors` method on our `Robot` class, an array, whose elements consist of the various classes and modules that comprise the _method lookup path_ of our `Robot` class, will be returned.  

```ruby
Robot.ancestors
# => [Robot, Object, Kernel, BasicObject] 
```

This method lookup path is the path our program will traverse when looking for any instance method called on an object of the `Robot` class. The `Robot` class, being the first in the list, will be searched first, followed by the `Object` class, the `Kernel` module, and finally, the `BasicObject` superclass. If a behaviour is defined in any of the classes/modules along that path, then the instance method corresponding to that behaviour will be accessible to objects of the `Robot` class. In this sense, we might think of instance methods as _instances_ of the behaviours defined in either the class or somewhere within its class inheritance hierarchy.  

Let's invoke the `talk` instance method on our Robot objects in order to expose the 'talk' behaviour defined in our `Robot` class.

```ruby
r2d2.talk
# => I'm a robot, and I can talk.
c3p0.talk
# => I'm a robot, and I can talk.
```

Invoking the `talk` method on each of the two distinct Robot objects outputs the same message to the screen: `I'm a robot, and I can talk.`. The message itself is irrelevant to our discussion, and indeed, we could have defined the 'talk' behaviour to do any number of things. The important part here is to realize that each of our Robot objects is only capable of performing the specified behaviour when the `talk` instance method is invoked because we have already defined that behaviour within our `Robot` class--essence precedes existence.

That's enough about behaviour for now. We will continue to talk about behaviours throughout the rest of the discussion but let's turn to the other aspect of essence as defined by class--attributes.    

###### Attributes and Instance Variables

Attributes have one _necessary_ property and two _contingent_ properties. You cannot define an attribute without the necessary property being inherent to that definition, but you can define an attribute without the two contingent properties.  

**The Necessary Property**

The necessary property of any attribute is the function of predetermining the state of any particular object. Every object's state derives its universal form or essence from the attributes defined in the object's class and any superclasses within the inheritance hierarchy. Thus, an object's state must, and indeed does, track the attributes defined in the object's class (LS OOP book) and class inheritance hierarchy. This means that an object can only possess instance variables that have been predetermined by the attributes defined within its respective class and superclasses.

There can be no _instance_ of an attribute without that attribute already being defined--essence precedes existence. This suggests that we should  think of instance variables as _instances_ of attributes defined in the class, similar to how we can view instance methods as _instances_ of behaviours defined in the class, and of course, instances (or objects) are just instances of the class itself.  

This leads to a very important and perhaps controversial point concerning ostensible variables whose names start with `@`. For example, in our `Robot` class definition above, we have `@name`. It would appear that we are dealing with an instance variable, but appearances can be deceiving. Here's what David Flanagan and Yukihiro Matsumoto have to say about instance variables in their book _The Ruby Programming Language_: "All Ruby objects have a set of instance variables. These are not defined by the object's class--they are simply created when a value is assigned to them." Classes don't define instance variables, they define attributes. Instance variables do not exist prior to an object being created and a value being assigned to them. 

The distinction between attributes and instance variables is important because it can be tempting to use the term 'attribute' and 'instance variable' interchangeably. This is fine so long as one keeps the distinction between what a class is and how it functions and what an object is and how it functions. If one is aiming for clarity, it might be best to speak of `@name` as an instance variable within the context of its belonging to a particular object, and to speak of `@name` as an _attribute signifier_ within the context of class definition. Within our `Robot` class definition, the presence of an `@name` attribute signifier will predetermine the existence of an `@name` instance variable inhering to every object of the `Robot` class. Evidently, context matters.

The fact that context matters really shouldn't be all that controversial. The Ruby programming language itself has no absolute sovereign authority over the use of the arobase sign, `@`. In the English language, at least, it's a substitute for "at", and it's used as a prefix for Instagram handles by people who have no clue what an instance variable is (imagine we started to call them Instagram instance variables). Thus, to speak of `@name` as an attribute signifier within the context of class definition and as an instance variable within the context of any particular object of the class shouldn't be that problematic.  

**Contingent Properties**

The two contingent properties of attributes are both behaviours, which means that there is some overlap between attributes and behaviours (we will explain this in more depth further below). These two  contingent properties correspond to the two types of Ruby accessor methods: 1) getter methods and 2) setter methods. To illustrate what we mean by getter and setter methods, let's define one of each within our `Robot` class.

```ruby
class Robot
  # ... rest of code omitted for brevity
  
  def name	# Here, we define a behaviour corresponding to a getter method.
    @name
  end
  
  def name=(name)  # Here, we define a behaviour corresponding to a setter method.
    @name = name
  end
end
```

Both the getter and setter method defined above look like behaviours, and as already mentioned above, they are. But they are also attributes; or more specifically, they are contingent properties of our 'name' attribute. Each property is contingent, and although we can define either one without an attribute already being defined, once either one of them is defined, the attribute is necessarily defined.

For example, let's completely redefine our `Robot` class without the `initialize` constructor method but with a behaviour corresponding to a `name` getter method.

```ruby
class Robot
  def name
    @name			# Here, we define a 'name' attribute with a contingent, behavioural property.
  end
  
  def talk
    puts "I'm a robot, and I can talk."
  end
end 
```

Again, it may appear that we have simply defined two behaviours within our class. But the first behaviour, the `name` getter-method definition, is also an attribute, because it contains a line of code that satisfies the necessary property of any attribute. The state of any object of the `Robot` class will be predetermined by the 'name' attribute defined therein, so that the totality of the state of any Robot object will consist of an `@name` instance variable.

What is special about this 'name' attribute that distinguishes it from the 'name' attribute we defined in our first definition of the `Robot` class, is that this 'name' attribute has the behavioural property of being able to be publicly exposed. Remember that when we tried to expose the value associated with our `@name` instance variable for the `r2d2` Robot object by appending that object with `name` above, an "undefined method" error message was returned. But with a `name` getter method, we are able to directly access the object's `@name` instance variable and expose the value associated with it.

Similarly, if we were to add a `name` setter-method definition to the definition of our `Robot` class, we would also be able to access any Robot object's `@name` instance variable and change its value. Let's add a setter- and getter-method definition to our initial `Robot` class in order to play around with a few examples.

```ruby
class Robot
  def initialize(name) # Constructor method: invoked whenever we instantiate a new object.
    @name = name   		# Here, we define an attribute signifier for a 'name' attribute.
  end
  
  def name		# Here, we are adding a 'getting' behaviour to our 'name' attribute.
    @name			# The 'getting' behaviour is a contingent property of the attribute.
  end
  
  def name=(name) # Here, we are adding a 'setting' behaviour to our 'name' attribute.
    @name = name  # The 'setting' behaviour is a contingent property of the attribute.
  end
  
  def talk		# Here, we define a 'talk' behaviour within the class.
    puts "I'm a robot, and I can talk."
  end
end 
```

Let's test them out with one of our Robot objects.

```ruby
c3p0.name
# => "C3P0"
c3p0.name = "Buzz"
c3p0.name
# => "Buzz"
```

Success! We are able to both expose and change the value associated with the `c3p0` object's `@name` instance variable. 

Getter and setter methods are so common that Ruby has a built-in way of defining them within the class. We can use `attr_reader` to define a getter method, `attr_writer` to define a setter method, or `attr_accessor` to simultaneously define a getter and setter method. Each of these methods take a symbol as an argument. Here's what our code would look like if we replaced our `name` getter-method and `name=` setter-method definitions with a single `attr_accessor`.

```ruby
class Robot
  attr_accessor :name
  
  def initialize(name) # Constructor method: invoked whenever we instantiate a new object.
    @name = name   		# Here, we define an attribute signifier for a 'name' attribute.
  end
  
  def talk		# Here, we define a 'talk' behaviour within the class.
    puts "I'm a robot, and I can talk."
  end
end 
```

And we haven't lost any functionality...

```ruby
c3p0.name
# => "C3P0"
c3p0.name = "Buzz"
c3p0.name
# => "Buzz"
```

...as we are able to expose and change the value associated with our `c3p0` object's `@name` instance variable.  

But we need to reiterate why it is that we are treating these two behaviours as contingent properties of our 'name' attribute and not just independent behaviours. The reason has to do with the Object Oriented Programming paradigm and one of its primary goals--_encapsulation_.

##### Encapsulation

It might help to think about Ruby local variables here. Suppose we initialize a local variable with the name `robot_name` and assign it to the value `"Buzz"`.

```ruby
robot_name = "Buzz"
```

Notice what happens when we try to return the value referenced by this local variable.

```ruby
robot_name
# => "Buzz"
```

We get what we wanted. What about if we try to change the value associated with the `robot_name` local variable by reassigning it to a new value?

```ruby
robot_name = "Fuzz"
robot_name
# => "Fuzz"
```

Again, we get just what we wanted. But notice how we were able to access our local variable, expose it and change it, and all without giving these processes a second thought. It's as if we take these behavioural properties of being able to expose and change the local variable's value for granted, as if those properties are inherent to the very essence of being a local variable. This is not the case for instance variables. The flexibility that belongs to instance variables, allowing them to preclude such behaviours, is precisely the precondition for encapsulation.

Encapsulation is a form of data protection that allows programmers to hide functionality from the rest of the code base (LS OOP book somewhere). When we define an attribute within a class, we have the flexibilty to decide what sorts of properties will belong to it.  Once decided, those properties will predetermine the level of access available to the rest of the code base outside of the class; that is, whether the values associated with instance variables are able to be exposed or changed will be predetermined by how we define the attributes within the class.

[Image depicting differences between local variables and instance variables]

##### A Note on State and Attribute Tracking

We claimed above that an object's state tracks the attributes defined within the object's class. We want to explain that idea in a little more depth here. Let's use our last definition of the `Robot` class.

```ruby
class Robot
  attr_accessor :name
  
  def initialize(name) 
    @name = name		
  end
  
  def talk
    puts "I'm a robot, and I can talk."
  end
end 
```

Now let's create a new instance, or object, of the `Robot` class.

```ruby
alexa = Robot.new("Alexa")
```

[insert image of robot object]

If we invoke the `p` method on our `alexa` Robot object, the following is returned...

```ruby
p alexa
# => #<Robot:0x00007f9c5d0f6198 @name="Alexa"> 
```

Thus, we can see that our `alexa` object has an `@name` instance variable associated with the value `"Alexa"`. That instance variable is keeping track of our object's state, but our state is tracking the attributes defined in the class for our object. Let's explain.

Suppose that we wanted all Robot objects of the `Robot` class to have the potential to posses musical abilities. Without performing any action on individual Robot objects themselves, we can simply define a 'musical' attribute within our `Robot` class and the state of every existing instance, or object, of the `Robot` class, will now be tracking this attribute. Let's add it, and we will make sure to give it the two contingent behavioural properties of being able to be exposed and changed.

```ruby
class Robot
  attr_accessor :name, :musical  # We add a 'musical' attribute to our class definition.
  
  def initialize(name) 
    @name = name		
  end
  
  def talk
    puts "I'm a robot, and I can talk."
  end
end 
```

Without instantiating any new Robot object, let's see what happens when we call the `p` method again on our `alexa` object.

```ruby
p alexa
# => #<Robot:0x00007f9c5d0f6198 @name="Alexa">
```

Hmmm...it would seem that our object does not possess an `@musical` instance variable that would correspond to the newly defined 'musical' attribute in our class definition. But that doesn't mean the object's state is not aware of the newly added 'musical' attribute. Indeed, it is aware, which is why we can run the following bit of code without raising an exception, or error.

```ruby
alexa.musical
# => nil
```

The return value of `nil` may seem uninteresting since we have not yet assigned a value to any `@musical` instance variable. However, this little example has tremendous significance, for it demonstrates that somehow, something pertaining to our `alexa` object is aware that something like a 'musical' attribute exists. That something is the object's state. The state is keeping track of all the attributes defined within the class. If it wasn't, we should expect `alexa.musical` to return some error message instead of `nil`.

This example suggests another important point that needs to be made. The reason that our invocation of the `p` method on `alexa` did not produce any indication of a 'musical' attribute nor a corresponding `@musical` instance variable, is that the `@musical` variable is as of yet, uninitialized. All uninitialized instance variables reference `nil`. The `@musical` instance variable has a certain shadowy existence at this point. It is not non-existent, but its existence is a kind of null existence, or 'nil' existence.

To bring the example to life a little bit, let's suppose that we have a robot named Alexa and Alexa has been created with the potential for musical abilities. Currently, Alexa does not play any instrument, nor does she sing, but she has latent musical abilities that exist _in potentia_. Her musical abilities do not have a positive existence. Her musical abilities are not nothing, as they would be say for a rock, but they do have a kind of null, or nil, existence (to speak of the musical abilities of a rock would be to speak nonsense). Even in the world of numbers, zero is still a value nonetheless.

[insert image of robot object state]

But now let's say Alexa starts practicing the guitar. All of a sudden, Alexa's musical abilities have a positive existence--she now has musical abilities. It's as if practicing the guitar _initialized_ Alexa's musical potential and brought it out of its 'nil' existential state. If we were to try to mimic this example with code, we could define a few 'practice' behaviours pertaining to different musical instruments within our `Robot` class.

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

Let’s initialize the musical abilities of `alexa` by invoking the `practice_guitar` and `practice_piano` methods.

```ruby
alexa.practice_guitar
alexa.practice_piano
puts alexa.musical
# => I play guitar
# => I play piano
```

The state of `alexa` has been transformed as the `@musical` instance variable has been initialized and assigned with new values. Notice that the invocation of the `practice_guitar` method _initializes_ the `@musical` instance variable; the call to the `musical` getter method in the ternary operator returns the `nil` value associated with the `@musical` instance variable, and this _falsey_ value causes the ternary operator to evaluate to `false`, which in turn leads to the `self.musical = ['I play guitar']` section of code to the right of the `:` operator being executed instead of the `self.musical << 'I play guitar'` section of code.

However, since the `@musical` instance variable has already been initialized when we invoke the `practice_piano` method on `alexa`, the `musical` getter method returns `["guitar"]`, which is a _truthy_ value and thus the ternary operator evaluates to `true`. That causes the `self.musical << 'I play piano'` section of code to be executed instead of the `self.musical = ['I play piano']` section of code.

The `alexa` object's latent musical abilities have now been realized through praciticing the guitar and the piano. She is still the same Robot object, but her state has been transformed--she is the same, but different. We could continue to transform the state of `alexa` by invoking the `practice_singing` method on `alexa`, and the `@musical` instance variable would keep track of this change. Thus, while state tracks attributes for the object, instance variables keep track of an object's state.

##### Conclusion  

To sum up. Classes are forms that predetermine the particular objects or instances of the class. The essence of any particular object is defined within the Class. This essence is comprised of behaviours and attributes. When an object is instantiated it endowed with a state, which is prefigured by the attributes of the class and indeed which tracks those attributes.

- mention something about inheritance (i.e. about how attributes and behaviours are inherited)
- 

---









1) (give analogy with local variables; then show how this flexibility of defining attributes with or without the sub-properties is precisely the precondition for encapsulation, which is one of the goals of Object Oriented Programming; the ability to get and set local variables is inherent to local variables, but with attributes we can define them with or without those abilities)

2) then go introduce a new attribute 'musical' to illustrate in more depth the idea that state tracks attributes: we introduced a new attribute and without having to recreate any of our objects, the state of our objects are aware of the new attribute--it has become a part of the essence of every instance of the class. This might make it tempting to think that essence doesn't necessarily precede existence after all, but we must remember that before any attribute to be tracked by state it must first be defined within the class--the essence must be defined before it can be manifest in a object's state.

3) then invoke a getter `musical` method and show how it returns `nil` and show using `p` that it appears that the 'musical' attribute is not being tracked. We could continue to transform



---

Redo the diagram with state encapsulated within the object: 1) have the instance variables in the text of a color that corresponds to attributes and their values a different color; for each object the instance variables will all have the same color indicating that they are the universal aspect, but the values will all be different colors to illustrate that they are the unique or particular aspect. 





The existence of `@name` within the body of the getter method predetermines the state of any particular object of the `Robot` class; that is, every object of the `Robot` class will contain an `@name` instance variable.



These two methods are contingent because it's possible to define an attribute without either of these methods.













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

Alexa's latent musical abilities have now been realized through praciticing the guitar and the piano. She is still the same robot, but her state has been transformed — she is the same, but different. We could continue to transform the state of `alexa` by invoking the `practice_singing` method on `alexa`, and the `@musical` instance variable would keep track of this change. Thus, while state tracks attributes for the object, instance variables keep track of an object's state.

#### Concluding Remarks

To sum up this rather lengthy discussion, here is a list of some of the major points that were covered:

1. Classes define an essence for objects, consisting of attributes and behaviours.
2. Objects are instantiated from classes and are predetermined by the class definition.
3. An object’s state tracks the attributes of the class, and an object’s instance variables keep track of its state.
4. Class behaviours predetermine the instance methods pertaining to every particular object of the class.
5. Class attributes predetermine the instance variables pertaining to every particular object of the class.
6. Attributes may posses two contingent behavioural properties, and the contingency of these two properties is a precondition for encapsulation.

Those are the major points. Obviously, there are many things we didn’t discuss, such as how to think about class variables and constant variables and whether or not we can neatly file them under the term attribute. The important thing here was outline as much of the core model around objects and classes without going to deep into the exceptions.

We also didn’t say much about inheritance. But based on the general model outlined here, we can say that when one class inherits from another, it inherits both attributes and behaviours. Based on the distinction between attributes and instance variables that we have made, it should be evident that classes don’t inherit instance variables. Instance variables are unique to their particular objects and do not exist outside of them.

One last point. We’ve emphasized how in the OOP paradigm within Ruby, essence precedes existence. There may be a slight exception, however — duck typing. “If it walks like a duck and quacks like a duck, then it must be a duck.” Regardless of what class a particular object is instantiated from, if it is able to behave in a way that is similar to how objects instantiated from other classes behave, then such objects may be able to be treated as a common type for certain applications. Thus, the existentialists have a point: existence may indeed precede essence. Of course, Plato would argue that even similar behaviours must be codified prior to any being’s ability to perform those behaviours. But it’s nice that even Ruby provides us with some of the dynamism and ambiguity existing in the real world.





I want to say one more thing specific to the idea that state's track attributes in order to flesh out why this idea should be emphasized. Consider our `Robot` class. Suppose we add another `attr_accessor` getter/setter method for a 'love' attribute. Notice that we make this change directly in the class itself without doing anything to any of our already existing Robot objects. If the states of our respective objects are indeed tracking the attributes of the class, then then there will exist uninitialized instance variables associated with the 'love' attribute without having invoked any method on any of our objects. Those unitialized local variables are in a latent state, and are already at work, keeping track of the object's state. In this case the unitialized `@love` instance variable is associated with the value `nil`. Our robots have the potential for 'love', but that potential has yet to become a substantive reality.

