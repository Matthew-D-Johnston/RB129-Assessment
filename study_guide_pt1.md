##### Courses > RB129 Assessment: Object Oriented Programming > Instructions for Assessment RB129

---

## Part 1: Study Guide for Test

### Specific Topics of Interest

* Classes and objects
* Use `attr_*` to create setter and getter methods
* How to call setters and getters
* Instance methods vs. class methods
* Referencing and setting instance variables vs. using getters and setters
* Class inheritance, encapsulation, and polymorphism
* Modules
* Method lookup path
* self
  * Calling methods with self
  * More about self
* Reading OO code
* Fake operators and equality
* Truthiness
* Working with collaborator objects

---

#### Classes and objects  

###### Classes & Objects

* "In Ruby, everything is an object!"
* Creating objects allows programmers to think on a new level of abstraction. Objects are represented as real-world nouns and can be given methods that describe the behaviour the programmer is trying to represent.
* Objects are created from classes. Think of classes as molds and objects as the things you produce out of those molds. Individual objects will contain different information from other objects, yet they are instances of the same class. 
* Ruby defines the attributes and behaviours of its objects in **classes**.
* You can think of classes as basic outlines of what an object should be made of and what it should be able to do.
* The entire workflow of creating a new object or instance from a class is called **instantiation**.
* When defining a class, we typically focus on two things: _states_ and _behaviours_. States track attributes for individual objects. Behaviours are what objects are capable of doing. Instance variables keep track of state, and instance methods expose behaviour for objects.
* Objects do not share state between other objects, but do share behaviours. Put another way, the values in the objects' instance variables (states) are different, but they can call the same instance methods (behaviours) defined in the class.
* Classes also have behaviours not for objects (class methods).
* Classes group common behaviours and objects encapsulate state.
* The object's state is saved in an object's instance variables. 



---

#### Use `attr_*` to create getter and setter methods  

* Because _getter_ and _setter_ methods are so commonplace, Ruby has a built-in way to automatically create them for us, using the **attr_accessor** method. 
* The `attr_accessor` method takes a symbol as an argument, which it uses to create the method name for the `getter` and `setter` methods. 
* If we only want the getter method without the setter method then we would want to use the `attr_reader` method. It works the same way but only allows you to retrieve the instance variable. And if you only want the setter method, you can use the `attr_writer` method.
* All of the `attr_*` methods take a `Symbol` as parameters.

---

#### How to call getters and setters

* When a setter is private: unlike all other private method calls, you _must_ specify the caller when calling a setter method.



---

#### Instance Methods vs. Class Methods

* The `initialize` method gets called every time you create a new object. That's odd, don't we call the `new` method when we create an object? Yes, calling the `new` class method eventually leads us to the `initialize` instance method. We refer to the `initialize` method as a _constructor_, because it gets triggered whenever we create a new object. You can pass arguments into the `initialize` method through the `new` method.
* All objects of the same class have the same behaviours, though they contain different states.
* Class methods are methods we can call directly on the class itself, without having to instantiate any objects.
* When defining a class method, we prepend the method name with the reserved word `self.`.
* Class methods are where we put functionality that does not pertain to individual objects. Objects contain state, and if we have a method that does not need to deal with states, then we can just use a class method.
* Instance methods can operate on the instance variables.

###### Instance Variable Scope

* Instance variables are variables that start with `@` and are scoped at the object level.
* Because the scope of instance variables is at the object level, this means that the instance variable is accessible in an object's instance methods, even if it's initialized outside of that instance method.
* Unlike local variables, instance variables are accessible within an instance method even if they are not initialized or passed in to the method. Remember, their scope is at the _object level_.
* Another distinction from local variables is that if you try to reference an uninitialized local variable, you'd get a `NameError`. But if you try to reference an uninitialized instance variable, you get `nil`.
* Initialize instance variables within instance methods.
* Instance variables behave the way we'd expect. The only thing to watch out for is to make sure the instance variable is initialized before referencing it.

###### Class Variable Scope

* Class variables start with `@@` and are scoped at the class level. They exhibit two main behaviours:
  * all objects share 1 copy of the class variable. (This also implies objects can access class variables by way of instance methods.)
  * class methods can access class variables, regardless of where it's initialized.
* Only class variables can share state between objects (we're going to ignore globals.).
* Inheritance can lead to class variables being affected in unexpected and undesirable ways. Redefining a class variable in a sub-class can override its definition in the super-class and all other sub-classes that inherit from it. For this reason, avoid using class variables when working with inheritance. In fact, some Rubyists would go so far as recommending avoiding class variables altogether.
* Class variables have a very insidious behaviour of allowing sub-classes to override super-class class variables. Further, the change will affect all other sub-classes of the super-class. This is extremely unintuitive behaviour, forcing some Rubyists to eschew using class variables altogether.

###### Constant Variable Scope

* Constants begin with a capital letter and have _lexical_ scope.
* Constants are available in class methods or instances methods (which implies they are accessible from objects). 
* In order to access a constant defined in another class, we need to use `::`, the namespace resolution operator.
* A constant initialized in a super-class is inherited by the sub-class, and can be accessed by both class and instance methods.
* Constants have _lexical scope_ which makes their scope resolution rules very unique compared to other variable types. If Ruby doesn't find the constant using lexical scope, it'll then look at the inheritance hierarchy.

---

#### Referencing and setting instance variables vs. using getters and setters  

With getter and setter methods, we have a way to expose and change an object's state. We can also use these methods from within the class as well. In the previous section, the `speak` method referenced the `@name` instance variable, like below:

```ruby
def speak
  "#{@name} says arf!"
end
```

Instead of referencing the instance variable directly, we want to use the `name` getter method that we created earlier, and that is given to us now by `attr_accessor`. We'll change the `speak` method to this:

```ruby
def speak
  "#{name} says arf!"
end
```

Can you spot the change? By removing the `@` symbol, we're now calling the instance method, rather than the instance variable.  

Why do this? Why not just reference the `@name` instance variable, like we did before? Technically, you could just reference the instance variable, but it's generally a good idea to call the _getter_ method instead.  

However, we have to beware that when calling getter or setter methods, we use clear syntax so that Ruby does not think we are calling or setting _local variables_. To disambiguate from creating a local variable, we sometimes need to prefix our getter- and setter-method calls with `self` to let Ruby know that we're calling a method.

* It is standard practice to refer to instance variables inside the class without `@` if the getter method is available.

---

#### Class inheritance, encapsulation, and polymorphism  

###### Encapsulation

**Encapsulation** is hiding pieces of functionality and making it unavailable to the rest of the code base. It is a form of data protection, so that data cannot be manipulated or changed without obvious intention. It is what defines the boundaries in your application and allows your code to achieve new levels of complexity. Ruby, like many other OO languages, **accomplishes this task by creating objects, and exposing interfaces (i.e., methods) to interact with those objects.**  

Encapsulation hides the implementation details of a class from other objects.  

Encapsulation lets us hide the internal representation of an object from the outside and only expose the methods and properties that users of the object need. We expose these properties and methods through the public interface of a class: its public methods.  

Classes group common behaviours and **objects encapsulate state**.

###### Polymorphism  

**Polymorphism** is the ability for data to be represented as many different types. "Poly" stands for "many" and "morph" stands for "forms". OOP gives us flexibility in using pre-written code for new purposes.  

Another way to apply polymorphic structure to Ruby programs is to use a `Module`. Modules are similar to classes in that they contain shared behaviour. However, you cannot create an object with a module. A module must be mixed in with a class using the `include` method invocation. This is called a **mixin**. After mixing in a module, the behaviours declared in that module are available to the class and its objects.  

Polymorphism is the process of using an operator or function in different ways for different data input.  

Polymorphism refers to the ability of different objects to respond in different ways to the same message (or method invocation).

There are several ways to implement polymorphism.

1. Polymorphism through inheritance
2. Polymorphism through duck typing

###### Inheritance  

* The concept of **inheritance** is used in Ruby where a class inherits the behaviours of another class, referred to as the **superclass**. This gives Ruby programmers the power to define basic classes with large reusability and smaller **subclasses** for more fine-grained, detailed behaviours.  
* Inheritance is when a class inherits behaviour from another class. The class that is inheriting behaviour is called the subclass and the class it inherits from is called the superclass.
* Ruby checks the object's class first for the method before it looks in the superclass.
* Inheritance can be a great way to remove duplication in your code base. There is an acronym that you'll see often in the Ruby community, "DRY". This stands for "Don't Repeat Yourself". It means that if you find yourself writing the same logic over and over again in your programs, there are ways to extract that logic to one place for reuse.
* Sub-classing from parent class. Can only sub-class from 1 parent; used to model hierarchical relationships.

---

#### Modules  

* A way to apply polymorphic structure to Ruby programs.
* Modules are similar to classes in that they contain shared behaviour. However, you cannot create an object with a module. A module must be mixed in with a class using the `include` method invocation. This is called a **mixin**. After mixing in a module, the behaviours declared in that module are available to the class and its objects.
* A **module** is a collection of behaviours that is usable in other classes via **mixins**.
* Using modules to group common behaviours allows us to build a more powerful, flexible and DRY design.
* Can mix in as many modules as needed.
* Modules are Ruby's way of implementing _multiple inheritance_. A class can only sub-class from one parent, bit it can mix in as many modules as it likes.

##### Inheritance vs. Modules

* Now that you know the two primary ways that Ruby implements inheritance, class inheritance and mixing in modules, you may wonder when to use one vs the other. Here are a couple of things to remember when evaluating those two choices.  

  * You can only subclass from one class. But you can mix in as many modules as you'd like.
  * If it's an "is-a" relationship, choose class inheritance. If it's a "has-a" relationship, choose modules. Example: a dog "is an" animal; a dog "has an" abillity to swim.
  * You cannot instantiate modules (i.e., no object can be created from a module). Modules are used only for namespacing and grouping common methods together.
* When a module is included in a class, the class is searched before the module. But, the module is searched before the superclass. This order of precedence applies to all modules and classes in the inheritance hierarchy.
  
##### Modules and Namespacing  

* In this context, namespacing means organizing similar classes under a module. In other words, we'll use modules to group related classes.
  
  * One advantage of namespacing is that it makes it easy for us to recognize related classes in our code. 
* The second advantage is it reduces the likelihood of our classes colliding with other similarly named classes in our codebase.
  
##### Modules as Containers (Module Methods)

  * This involves using modules to house other methods.
  * This is very useful for methods that seem out of place within your code.



---

#### Method Lookup Path  

* Ruby has a distinct lookup path that it follows each time a method is called.
* We can use the `ancestors` method on any class to find out the method lookup chain.  
* The method lookup path is the order in which classes are inspected when you call a method.
* The method lookup path is the order in which Ruby will traverse the class hierarchy to look for methods to invoke.
* The order in which we include modules is important. Ruby actually looks at the last module we included _first_. This means that in the rare occurrence that the modules we mix in contain a method with the same name, the last module included will be consulted first. 
* Modules included in a superclass will also make it on to the method lookup path.
* When a module is included in a class, the class is searched before the module. But, the module is searched before the superclass. This order of precedence applies to all modules and classes in the inheritance hierarchy.



---

#### self

* To disambiguate from creating a local variable, we sometimes need to prefix our getter- and setter-method calls with `self` to let Ruby know that we're calling a method.
* When defining a class method, we prepend the method name with the reserved word `self.`.
* We use `self` to specify a certain scope for our program. `self` can refer to different things depending on where it is used.
* Here are at least two clear use cases for `self`: 1) use `self` when calling setter methods from within the class to allow Ruby to disambiguate between initializing a local variable and calling a setter method; and 2) use `self` for class method definitions.
* From within the class, when an instance method calls `self`, it is returning the _calling object_.
* So just to be clear, from within a class...
  1. `self`, inside of an instance method, references the instance (object) that called the method--the calling object.
  2. `self`, outside of an instance method, references the class and can be used to define class methods.
* So we can see that `self` is a way of being explicit about what our program is referencing and what our intentions are as far as behaviour. `self` changes depending on the scope it is used in, so pay attention to see if you're inside an instance method or not.
* The Ruby style guide instructs that we "Avoid self where not required."

---

#### Reading OO code



---

#### Fake operators and equality

* Fake operators, that is operators that are actually methods, can have their functionality overridden.

###### Equality methods

* One of the most common fake operators to be overridden is the `==` equality operator.
* It's very useful to override this method, and doing so also gives us a `!=` method.
* The original `==` method is defined in the `BasicObject` class, which is the parent class for _all_ classes in Ruby. This implies _every_ object in Ruby has a `==` method. However, each class should override the `==` method to specify the value to compare.
* for most objects, the `==` operator compares the values of the objects, and is frequently used.
* by default, `BasicObject#==` does not perform an equality check; instead, it returns true if two objects are the same object. This is why other classes often override the behaviour of `#==`.
* If you need to compare custom objects, you should override the `==` method.
* the `equal?` method goes one level deeper than `==` and determines whether two variables not only have the same value, but also whether they point to the same object.
* do not override `equal?`.
* calling `object_id` on an object will return the object's unique numerical value. Comparing two objects' `object_id` has the same effect as comparing them with `equal?`.
* `===` is used implicitly in `case` statements.
* like `==`, the `===` operator is actually a method.
* you rarely need to call this method explicitly, and only need to implement it in your custom classes if you anticipate your objects will be used in `case` statements, which is probably pretty rare.

---

#### Truthiness



---

#### Working with collaborator objects

* We can use any object to represent an object's state. Instance variables can be set to any object, even an object of a custom class we've created.  
* Objects that are stored as state within another object are also called "collaborator objects". We call such objects collaborators because they work in conjunction (or in collaboration) with the class they are associated with. 
* When we work with collaborator objects, they are usually custom objects (e.g. defined by the programmer and not inherited from the Ruby core library). Yet, collaborator objects aren't strictly custom objects. Even string objects can act as collaborator objects.
* Collaborator objects play an important role in object oriented design, since they also represent the connections between various actors in your program. When working on an object oriented program be sure to consider what collaborators your classes will have and if those associations make sense, both from a technical standpoint and in terms of modeling the problem your program aims to solve.
* When working with collaborator objects in your class, you may be working with strings, integers, arrays, hashes, or even custom objects. Collaborator objects allow you to chop up and modularize the problem domain into cohesive pieces; they are at the core of OO programming and play an important role in modeling complicated problem domains.