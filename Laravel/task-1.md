# IEEE ZSB phase 3: Laravel

---

## Blade templates

* Blade is Laravel’s built-in template engine that allows developers to write dynamic HTML with embedded PHP in a more readable and maintainable way. Unlike traditional PHP templates, Blade provides template inheritance and reusable components, making development much more efficient.

### **Why Use Blade?**

1. Cleaner Syntax: Blade’s directives make writing dynamic views easier than using raw PHP.

2. Template Inheritance: Allows you to define a base layout and extend it in child templates.

3. Reusable Components: Blade makes it easy to create reusable UI components.

**Most essential Blade directives:** 

1. Conditionals (`@if`, `@unless`, `@isset`)

2. Loops (`@foreach`, `@forelse`)

3. Layouts & Inheritance (`@extends`, `@section` , `@yield`)

4. Authentication Directives (`@auth`, `@guest`)

5. Security & Forms (`@csrf`, `@method`)

----

## ORM (Object-Relational Mapping)

* ORM is a technique used in creating a "bridge" between object-oriented programs and relational databases.

* An ORM provides a map that connects your code directly to your database schema:

|               In Your Code (OOP)                  |         In Your Database (SQL)        | 
| --------------------------------------------------| ------------------------------------- | 
| Class (e.g., `class User`)                        | Table (e.g., `users` table)           | 
| Object Instance (e.g., `$user = new User()`)      | Row (A specific record in the table)  | 
|Property (e.g., $user->email)                      | Column (The `email` field in that row)|


**Raw SQL / PDO Style:**

```php 
$stmt = $pdo->prepare("SELECT * FROM users WHERE status = 'active' AND country = 'Egypt' ORDER BY name ASC");
$stmt->execute();
$users = $stmt->fetchAll(PDO::FETCH_ASSOC);

```

**Eloquent Style:**

```php 
$users = User::where('status', 'active')
             ->where('country', 'Egypt')
             ->orderBy('name', 'asc')
             ->get();
```

### pros 

1. Fast Development: You write significantly less boilerplate code.

2. Database Agnostic: Since the ORM generates the SQL, you can often switch your underlying database (e.g., moving from SQLite during local testing to MySQL in production)

3. Built-in Security: Most ORMs automatically use parameterized queries, neutralizing the risk of SQL injection out of the box.

### cons

1. Performance Overhead: Because the ORM abstracts the SQL generation, it can sometimes create highly inefficient queries (like the famous N+1 query problem when loading relationships) if you aren't careful.

2. Loss of Fine Control: For incredibly complex report queries or massive data analytics optimization, writing optimized raw SQL is still superior.


----

## Facade Design Pattern 

* The Facade Design Pattern is a structural pattern that provides a simple and unified interface to a complex subsystem. It hides the internal complexity of the system, making it easier to use and maintain.

* Structuring a system into subsystems helps reduce overall complexity and improves organization. A common design goal is to minimize communication and dependencies between these subsystems.

* The Facade Pattern achieves this by introducing a facade object that acts as a single entry point, providing a simplified interface to the underlying subsystem functionality.

**Real-life Example:** In a home automation system, a user controls lights, AC, and security cameras using a single app or panel. The control system acts as a Facade, hiding the complexity of multiple devices. It provides one simple interface to manage all subsystems efficiently.

### How Facades Work in Laravel

* Laravel facades are not traditional facades in the strictest sense. They use PHP’s magic methods to proxy static method calls to underlying instances in the service container.

1. You call a static method on a facade.

2. PHP’s __callStatic magic method intercepts the call.

3. The facade resolves the actual service from the container.

4. The method is called on the real service instance.

5. The result is returned to you.

```php
use Illuminate\Support\Facades\Cache;

// Store data in cache for 1 hour
Cache::put('user_preferences', $preferences, 3600);

// Retrieve data from cache
$preferences = Cache::get('user_preferences');

// Store forever
Cache::forever('site_settings', $settings);

// Check if cache exists
if (Cache::has('user_session')) {
    // Do something
}

// Remember: Cache or fetch
$users = Cache::remember('active_users', 3600, function () {
    return User::where('active', true)->get();
});

// Remove from cache
Cache::forget('temporary_data');
```

----

## Factory Design Pattern

* The Factory Design Pattern is a creational design pattern that provides an interface for creating objects in a superclass, but allows subclasses to alter the type of objects that will be created.

* Think of a factory pattern like a car manufacturing plant. Instead of handcrafting each car part by part, you have a standardized process that produces vehicles based on specifications. In Laravel, the Factory Pattern creates objects without exposing the creation logic to the client and refers to the newly created object through a common interface.

### pros 

1.  Generate realistic test data in seconds.

2. Consistency across your app - Same object creation logic everywhere

3. Cleaner code - No more messy object instantiation scattered around

4. apid prototyping - Spin up demo data faster than you can say `php artisan`

```php 
class UserFactory extends Factory
{
    public function definition(): array
    {
        return [
            'name' => fake()->name(),
            'email' => fake()->unique()->safeEmail(),
            'email_verified_at' => now(),
            'password' => Hash::make('password'),
            'remember_token' => Str::random(10),
        ];
    }
}
```
``` php 
public function test_user_can_create_post()
{
    $user = User::factory()->create();

    // That's it! One beautiful line. 🎉
}
```

---- 

## Solid Principles


**1. Single Responsibility Principle (SRP)**

* A class should have one, and only one, reason to change. It means an object or function should not be multi-tasking or handling mixed responsibilities (e.g., mixing business logic with notification logic).

```php
class OrderManager {
    public function processOrder($order) {
        // Core business processing logic
    }
    
    public function processPayment($order) {
        // Payment logic handling Visa/MasterCard
    }

    public function sendEmailNotification($order) {
        // SMTP and Email body formatting logic
    }
}
```
***Code Solution (Splitting Responsibilities)***

```php
class OrderManagement {
    public function process($order) { /* Process Order Only */ }
}

class PaymentProcessor {
    public function process($order) { /* Handle Payment Only */ }
}

class NotificationService {
    public function sendEmail($order) { /* Handle Emails Only */ }
}
```
---

**2. Open/Closed Principle (OCP)**

* Software entities (classes, modules, functions) should be open for extension but closed for modification. You should be able to introduce a new behavior or type without altering any existing codebase files.

```php
class DiscountCalculator {
    public function calculate($product) {
        // Modifying this class every time a product type is added violates OCP
        switch($product->type) {
            case 'Electronics': return $product->price * 0.10;
            case 'Clothing':    return $product->price * 0.20;
            case 'Books':       return $product->price * 0.15;
        }
    }
}
```

***Code Solution (Using Strategy Design Pattern)***

```php
interface DiscountStrategy {
    public function calculateDiscount($product);
}

class ElectronicsDiscount implements DiscountStrategy {
    public function calculateDiscount($product) { return $product->price * 0.10; }
}

// To add "HomeAppliances", just create a new class implementing the interface!
class DiscountCalculator {
    protected $strategy;
    public function __construct(DiscountStrategy $strategy) { $this->strategy = $strategy; }
    public function calculate($product) { return $this->strategy->calculateDiscount($product); }
}
```

---

**3. Liskov Substitution Principle (LSP)**

* Objects of a superclass should be replaceable with objects of its subclasses without breaking the application or altering the expected correct behavior of the system.

```php class Order {
    public function getTotalPrice() { return $this->price + $this->getShippingCost(); }
}

class DeliveryOrder extends Order { /* Works fine */ }

class PickUpOrder extends Order {
    // Violation! PickUp orders shouldn't charge shipping costs, 
    // replacing Order with PickUpOrder here breaks the uniform behavior expectation.
}
```
***Code Solution (Isolating distinct behaviors via specialized contracts)***

```php
class Order {
    public function getTotalPrice() { return $this->price; } // Uniform expectation
}

interface ShippingCostCalculator {
    public function calculateShipping();
}

class DeliveryOrder extends Order implements ShippingCostCalculator {
    public function calculateShipping() { return 10.00; }
}
```

---

**4. Interface Segregation Principle (ISP)**

* A client should never be forced to implement an interface or depend on methods it does not use. It is better to split massive "fat" interfaces into smaller, tightly focused ones.

```php
interface UserManagement {
    public function updateProfile();
    public function changePassword();
    public function subscribeToEmail();
    public function subscribeToSMS();
}

class Subscriber implements UserManagement {
    // Subscribers don't have user profiles or passwords, but are forced to implement them!
    public function updateProfile() { throw new Exception("Not supported"); } 
}
```

***Code Solution (Segregated Interfaces)***

```php
interface ProfileManagement {
    public function updateProfile();
    public function changePassword();
}

interface SubscriptionManagement {
    public function subscribeToEmail();
    public function subscribeToSMS();
}

// Cleaner execution targets
class Customer implements ProfileManagement, SubscriptionManagement { /* Implements all */ }
class Subscriber implements SubscriptionManagement { /* Implements only what is needed */ }
```

---


**5. Dependency Inversion Principle (DIP)**

* High-level modules should not depend on low-level modules; both must depend on abstractions. Furthermore, abstractions should not depend on details; details should depend on abstractions.

```php 
class PaymentProcessor {
    protected $visaCard;

    public function __construct() {
        // Tight coupling! High-level component depends directly on low-level Visa execution details
        $this->visaCard = new VisaCardPayment(); 
    }
}
```

***Code Solution (Inverting dependencies through an abstraction layer)***

```php 
interface PaymentMethodInterface {
    public function processPayment($amount);
}

class VisaCardPayment implements PaymentMethodInterface { /* Low-level detail */ }
class PayPalPayment implements PaymentMethodInterface { /* Low-level detail */ }

class PaymentProcessor {
    protected $paymentMethod;

    // Both depend on the abstraction injected externally via the constructor
    public function __construct(PaymentMethodInterface $paymentMethod) {
        $this->paymentMethod = $paymentMethod;
    }
}
```
