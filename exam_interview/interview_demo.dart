// =============================================================================
// ██████████████████████████████████████████████████████████████████████████████
//                     Flutter Interview Preparation Guide
//                     دليل الاستعداد الشامل لإنترفيو Flutter
// ██████████████████████████████████████████████████████████████████████████████
//
// هذا الملف يحتوي على أسئلة وأجوبة شاملة مع أمثلة عملية
// This file contains comprehensive Q&A with practical examples
//
// المحتويات / Table of Contents:
// ─────────────────────────────────────────────────────────────────────────────
//   Part 1: Dart Fundamentals - أساسيات Dart
//   Part 2: Flutter Widgets - ويدجت Flutter
//   Part 3: SOLID Principles - مبادئ SOLID
//   Part 4: State Management - إدارة الحالة
//   Part 5: Navigation - الملاحة
//   Part 6: Performance - الأداء
//   Part 7: Testing - الاختبار
//   Part 8: Common Interview Questions - أسئلة شائعة
//   Part 9: Advanced Topics - مواضيع متقدمة
//   Part 10: Animation Deep Dive - الأنيميشن بشكل تفصيلي
//   Part 11: Architecture Patterns - أنماط الاركتيكتشر
// ─────────────────────────────────────────────────────────────────────────────


// ██████████████████████████████████████████████████████████████████████████████
//                              PART 1
//                   Dart Fundamentals - أساسيات Dart
// ██████████████████████████████████████████████████████████████████████████████


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 1: ما الفرق بين var, final, const, dynamic في Dart؟           │
// │  Question 1: Difference between var, final, const, dynamic?            │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   ● var: متغير عادي، تقدر تغير قيمته والنوع بيتحدد تلقائياً من القيمة
//
//   ● final: ثابت في Runtime، تحدد قيمته مرة واحدة بس
//
//   ● const: ثابت في Compile Time، لازم قيمته معروفة وقت الكتابة
//
//   ● dynamic: النوع مش ثابت، ممكن يكون أي حاجة في أي وقت
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   ● var: A variable whose type is inferred from the assigned value
//
//   ● final: A runtime constant - can be assigned only once
//
//   ● const: A compile-time constant. Value must be known at compile time
//
//   ● dynamic: No type checking at compile time. Can hold any type
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

void example01_varFinalConstDynamic() {

  // ═══ var ═══
  var name = 'Ahmed';       // Type: String
  var age = 25;              // Type: int
  var height = 1.75;         // Type: double
  // name = 100;             // ERROR! Type already inferred as String

  // ═══ final ═══
  final DateTime now = DateTime.now();    // Determined at runtime
  final String username = 'admin';        // Can only be assigned once
  // now = DateTime(2025);                // ERROR! Already assigned

  // ═══ const ═══
  const int maxRetries = 3;
  const double pi = 3.14159;
  const String appName = 'MyApp';
  // maxRetries = 5;                      // ERROR! Compile-time constant

  // ═══ dynamic ═══
  dynamic anything = 'Hello';
  anything = 42;           // Changing type? Allowed
  anything = [1, 2, 3];    // Changing to List? Allowed

  print('var name: $name, Type: ${name.runtimeType}');
  print('final now: $now, Type: ${now.runtimeType}');
  print('const pi: $pi, Type: ${pi.runtimeType}');
  print('dynamic anything: $anything, Type: ${anything.runtimeType}');
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 2: الفرق بين Future و Stream                                   │
// │  Question 2: Difference between Future and Stream                       │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   ● Future: بيرجع نتيجة واحدة في المستقبل (زي Promise في JavaScript)
//     مثال: طلب HTTP واحد أو قراءة ملف واحد
//
//   ● Stream: بيرجع عدة قيم على مدار الوقت (زي WebSocket أو Real-time data)
//     مثال: Firestore updates أو WebSocket messages
//
//   ● الفرق الرئيسي:
//     - Future → نتيجة واحدة → Future<T>
//     - Stream → عدة قيم على مدار الوقت → Stream<T>
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   ● Future: Represents a single asynchronous result
//     Example: HTTP request returning one response
//
//   ● Stream: Represents a sequence of asynchronous events over time
//     Example: WebSocket messages, real-time database updates
//
//   ● Key Difference:
//     - Future → Single result → Future<T>
//     - Stream → Multiple values over time → Stream<T>
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// ═══ مثال على Future ═══
Future<String> fetchUserData() async {
  try {
    await Future.delayed(Duration(seconds: 2));
    return 'User: Ahmed';
  } catch (e) {
    return 'Error: $e';
  }
}

// ═══ مثال على Stream ═══
Stream<int> countStream() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i; // بيرجع القيمة ويستنى التانية
  }
}

// ═══ استخدام Stream ═══
void streamExample() async {
  await for (int value in countStream()) {
    print('Count: $value');
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 3: الـ Named Parameters و Optional Parameters                   │
// │  Question 3: Named Parameters and Optional Parameters                   │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Dart بيدعم Parameters بالطرق دي:
//
//   1. Positional Parameters (المواقع):
//      void greet(String name, int age) { ... }
//      greet('Ahmed', 25);
//
//   2. Named Parameters (بالاسم داخل {}):
//      void greet({required String name, int? age}) { ... }
//      greet(name: 'Ahmed', age: 25);
//
//   3. Optional Positional Parameters (اختياري داخل []):
//      void greet(String name, [int? age]) { ... }
//      greet('Ahmed');  // age هيبقى null
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Dart supports parameters in three ways:
//
//   1. Positional Parameters:
//      void greet(String name, int age) { ... }
//      greet('Ahmed', 25);
//
//   2. Named Parameters (wrapped in {}):
//      void greet({required String name, int? age}) { ... }
//      greet(name: 'Ahmed', age: 25);
//
//   3. Optional Positional Parameters (wrapped in []):
//      void greet(String name, [int? age]) { ... }
//      greet('Ahmed');      // age will be null
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class UserProfile {
  final String name;
  final int age;
  final String? email;
  final bool isVerified;

  // Named Parameters مع Required و Optional
  const UserProfile({
    required this.name,        // لازم يكون موجود (Required)
    required this.age,         // لازم يكون موجود (Required)
    this.email,                // اختياري (Optional)
    this.isVerified = false,   // اختياري مع قيمة افتراضية
  });

  @override
  String toString() =>
      'UserProfile(name: $name, age: $age, email: $email, isVerified: $isVerified)';
}

void example03_namedParameters() {
  // استخدام Named Parameters
  final user1 = UserProfile(
    name: 'Ahmed',
    age: 25,
    email: 'ahmed@example.com',
    isVerified: true,
  );

  final user2 = UserProfile(
    name: 'Sara',
    age: 23,
    // email اختياري، مش مضطر تبعته
  );

  print(user1);
  print(user2);
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 4: الـ Mixins في Dart                                          │
// │  Question 4: Mixins in Dart                                             │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Mixin هو شريحة كود مشتركة بين كلاسات كتير.
//   بيسمحلك تضيف وظائف لكلاسات كتير بدون Inheritance.
//
//   ليه نستخدم Mixin؟
//   1. لما عايز تضيف وظيفة لكلاسات كتير مش من نفس الأب
//   2. لما الـ Inheritance مش مناسب
//   3. عشان نتجنب Diamond Problem في الوراثة
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   A Mixin is a reusable body of code that can be applied to multiple classes.
//   It allows adding functionality without using inheritance.
//
//   When to use Mixins:
//   1. Adding same functionality to unrelated classes
//   2. When inheritance isn't suitable
//   3. To avoid the Diamond Problem
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// ═══ مثال على Mixin ═══
mixin Logger {
  void log(String message) {
    print('[LOG]: $message');
  }

  void logError(String error) {
    print('[ERROR]: $error');
  }
}

mixin Validator {
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool isValidPassword(String password) {
    return password.length >= 8;
  }
}

// ═══ استخدام Mixin مع `with` ═══
class UserService with Logger, Validator {
  void createUser(String name, String email, String password) {
    log('Creating user: $name');

    if (!isValidEmail(email)) {
      logError('Invalid email: $email');
      return;
    }

    if (!isValidPassword(password)) {
      logError('Invalid password');
      return;
    }

    log('User created successfully');
  }
}

// ═══ مثال تاني: Mixin مقيّد بنوع معين (Constrained Mixin) ═══
mixin AgeChecker<T extends num> {
  bool isAdult(T age) => age >= 18;
}

class Student with AgeChecker<int> {
  final String name;
  final int age;

  Student(this.name, this.age);

  String get status => isAdult(age) ? 'Adult' : 'Minor';
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 5: الـ Generics في Dart                                         │
// │  Question 5: Generics in Dart                                           │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Generics بتديك حرية تكتب كود يشتغل مع أي نوع بيانات.
//
//   ليه نستخدمها؟
//   1. Type Safety: بتحميك من الأخطاء في Compile Time
//   2. Code Reusability: بتكتب كود يشتغل مع أي نوع
//   3. Performance: أحسن من استخدام Object
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Generics allow you to write code that works with any data type.
//
//   Benefits:
//   1. Type Safety: Catches errors at compile time
//   2. Code Reusability: Write once, use with any type
//   3. Performance: Better than using Object
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// ═══ مثال على Generic Class ═══
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? error;

  ApiResponse({
    required this.success,
    this.data,
    this.error,
  });
}

// ═══ مثال على Generic Function ═══
T findFirst<T>(List<T> list, bool Function(T) predicate) {
  for (var item in list) {
    if (predicate(item)) {
      return item;
    }
  }
  throw StateError('No matching element found');
}

void example05_generics() {
  // استخدام مع String
  final stringResponse = ApiResponse<String>(
    success: true,
    data: 'Hello World',
  );

  // استخدام مع List
  final listResponse = ApiResponse<List<int>>(
    success: true,
    data: [1, 2, 3, 4, 5],
  );

  // استخدام مع Map
  final mapResponse = ApiResponse<Map<String, dynamic>>(
    success: true,
    data: {'name': 'Ahmed', 'age': 25},
  );

  print('String Response: ${stringResponse.data}');
  print('List Response: ${listResponse.data}');
  print('Map Response: ${mapResponse.data}');

  // استخدام Generic Function
  final numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  final firstEven = findFirst<int>(numbers, (n) => n.isEven);
  print('First even number: $firstEven');
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 6: الـ Extension Methods في Dart                                │
// │  Question 6: Extension Methods in Dart                                  │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Extension Methods بتديك إمكانية تضيف وظائف جديدة لكلاسات موجودة
//   من غير ما تعدل الكود الأصلي (Open/Closed Principle).
//
//   استخداماتها:
//   1. تحسين الـ APIs
//   2. إضافة وظائف مساعدة
//   3. كتابة كود أنظف وأقصر
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Extension Methods allow adding functionality to existing classes
//   without modifying the original code (Open/Closed Principle).
//
//   Use cases:
//   1. Improve APIs
//   2. Add helper functions
//   3. Write cleaner, shorter code
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// ═══ مثال على String Extension ═══
extension StringExtension on String {
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get camelCase {
    return split(' ').map((word) => word.capitalize).join();
  }

  bool get isNumeric => double.tryParse(this) != null;
}

// ═══ مثال على List Extension ═══
extension ListExtension<T> on List<T> {
  String get display {
    return '[${join(', ')}]';
  }

  List<T> get safeReverse {
    if (isEmpty) return [];
    return toList().reversed.toList();
  }
}

void example06_extensions() {
  String name = 'ahmed ali';
  print('Original: $name');
  print('Capitalize: ${name.capitalize}');
  print('CamelCase: ${name.camelCase}');
  print('Is numeric? "123": ${'123'.isNumeric}');
  print('Is numeric? "abc": ${'abc'.isNumeric}');

  List<int> numbers = [1, 2, 3, 4, 5];
  print('Original list: ${numbers.display}');
  print('Reversed list: ${numbers.safeReverse.display}');
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 7: الـ Null Safety في Dart                                      │
// │  Question 7: Null Safety in Dart                                        │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Null Safety ميزة في Dart 2.12+ بتمنعك تستخدم null بالخطأ.
//
//   المفاهيم الأساسية:
//   ● Nullable: String? (ممكن يكون null)
//   ● Non-Nullable: String (مش هيبقى null خالص)
//   ● Late: variable لسه مش جاهز في البداية بس هيتحدد بعدين
//   ● Required: لازم تبعت القيمة في الـ constructor
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Null Safety is a feature in Dart 2.12+ that prevents null-related errors.
//
//   Key Concepts:
//   ● Nullable: String? (can be null)
//   ● Non-Nullable: String (cannot be null)
//   ● Late: Variable not ready initially but will be initialized later
//   ● Required: Must be passed in the constructor
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class UserProfileNullSafe {
  final String name;           // Non-nullable
  final String? email;         // Nullable
  final int age;               // Non-nullable
  late final String bio;       // Late (يحتاج تعيين قبل الاستخدام)

  UserProfileNullSafe({
    required this.name,
    required this.age,
    this.email,
  }) {
    bio = 'I am $name, $age years old';
  }

  // Null Coalescing Operator (??)
  String get displayEmail => email ?? 'No email provided';

  // Null Assertion Operator (!)
  String get emailDomain => email!.split('@').last;
}

void example07_nullSafety() {
  final user1 = UserProfileNullSafe(
    name: 'Ahmed',
    age: 25,
    email: 'ahmed@example.com',
  );

  final user2 = UserProfileNullSafe(
    name: 'Sara',
    age: 23,
  );

  print('User 1: ${user1.name}, Email: ${user1.displayEmail}');
  print('User 2: ${user2.name}, Email: ${user2.displayEmail}');
  print('User 1 Bio: ${user1.bio}');
  print('User 1 Domain: ${user1.emailDomain}');
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 8: الـ Async/Await في Dart                                      │
// │  Question 8: Async/Await in Dart                                        │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Async/Await طريقة للكتابة بشكل أوضح للـ asynchronous code.
//
//   الكلمات المفتاحية:
//   ● async: بتحول الدالة لـ asynchronous
//   ● await: بستنى النتيجة من الـ Future
//   ● async*: بتحول الدالة لـ Stream
//   ● yield: بيرجع قيمة في الـ Stream
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Async/Await is a way to write cleaner asynchronous code.
//
//   Keywords:
//   ● async: Marks a function as asynchronous
//   ● await: Waits for a Future to complete
//   ● async*: Marks a function as returning a Stream
//   ● yield: Returns a value in a Stream
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Future<Map<String, dynamic>> fetchUserFromAPI(int userId) async {
  try {
    await Future.delayed(Duration(seconds: 2));

    if (userId <= 0) {
      throw Exception('Invalid user ID');
    }

    return {
      'id': userId,
      'name': 'User $userId',
      'email': 'user$userId@example.com',
    };
  } catch (e) {
    return {'error': e.toString()};
  }
}

Future<void> processUserData() async {
  try {
    final userData = await fetchUserFromAPI(1);
    if (userData.containsKey('error')) {
      print('Error: ${userData['error']}');
    } else {
      print('User: ${userData['name']}');
    }
  } catch (e) {
    print('Unexpected error: $e');
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 9: الـ Iterable في Dart                                         │
// │  Question 9: Iterable in Dart                                           │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Iterable هي واجهة بتمثل مجموعة من العناصر اللي تقدر تكرر عليها.
//
//   الفرق بين Iterable و List:
//   ● Iterable: Lazy evaluation (العناصر بتتحسب بس وقت الاستخدام)
//   ● List: Eager evaluation (العناصر كلها بتتحسب في البداية)
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Iterable is an interface representing a collection of elements
//   that can be iterated over.
//
//   Difference between Iterable and List:
//   ● Iterable: Lazy evaluation (elements computed on-demand)
//   ● List: Eager evaluation (all elements computed upfront)
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

void example09_iterable() {
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  // Iterable: Lazy - مش بيحسب القيم لحد ما يتعمل for
  Iterable<int> lazyNumbers = numbers
      .where((n) => n.isEven)
      .map((n) => n * 2);

  // List: Eager - بيحسب القيم فوراً
  List<int> eagerNumbers = numbers
      .where((n) => n.isEven)
      .map((n) => n * 2)
      .toList();

  print('Lazy Iterable: $lazyNumbers');
  print('Eager List: $eagerNumbers');

  // استخدام Iterable Methods
  print('First even: ${numbers.firstWhere((n) => n.isEven)}');
  print('Any > 5: ${numbers.any((n) => n > 5)}');
  print('Every > 0: ${numbers.every((n) => n > 0)}');
  print('Sum: ${numbers.reduce((a, b) => a + b)}');
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 10: الـ Typedefs في Dart                                        │
// │  Question 10: Typedefs in Dart                                          │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Typedef بتديك إمكانية تسمية الأنواع المعقدة عشان الكود يبقى أسهل.
//   مفيدة جداً لما بتستخدم Callbacks أو Function Types كتير.
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Typedefs allow you to name complex types for better readability.
//   Very useful when using Callbacks or Function Types frequently.
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

typedef Validator = bool Function(String value);
typedef AsyncFetcher<T> = Future<T> Function(int id);

class FormField {
  final String label;
  final Validator validator;

  FormField({required this.label, required this.validator});

  bool validate(String value) => validator(value);
}

void example10_typedefs() {
  final emailField = FormField(
    label: 'Email',
    validator: (value) => value.contains('@') && value.contains('.'),
  );

  final passwordField = FormField(
    label: 'Password',
    validator: (value) => value.length >= 8,
  );

  print('${emailField.label}: ${emailField.validate('ahmed@test.com')}');
  print('${passwordField.label}: ${passwordField.validate('12345678')}');
}


// ██████████████████████████████████████████████████████████████████████████████
//                              PART 2
//                      Flutter Widgets - ويدجت Flutter
// ██████████████████████████████████████████████████████████████████████████████


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 11: الفرق بين StatelessWidget و StatefulWidget                  │
// │  Question 11: Difference between StatelessWidget and StatefulWidget     │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   StatelessWidget:
//   ● ويدجت ثابتة، مش بتتغير بعد ما تتبنى
//   ● مفيهاش State (حالة)
//   ● الأداء أحسن لأنها مش بتتحقق من التغييرات
//   ● مثال: Text, Icon, Container (لما مفيش تغيير)
//
//   StatefulWidget:
//   ● ويدجت بتتغير مع الوقت (ممكن تتفاعل مع المستخدم)
//   ● فيها State (حالة) بتتغير
//   ● ليها lifecycle معقدة أكتر
//   ● مثال: Checkbox, TextField, AnimatedWidget
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   StatelessWidget:
//   ● Immutable widget, doesn't change after being built
//   ● Has no State
//   ● Better performance (no change detection needed)
//   ● Example: Text, Icon, Container (when static)
//
//   StatefulWidget:
//   ● Mutable widget that can change over time
//   ● Has State that can change
//   ● Has a complex lifecycle
//   ● Example: Checkbox, TextField, AnimatedWidget
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// ═══ مثال على StatelessWidget ═══
class GreetingWidget extends StatelessWidget {
  final String name;

  const GreetingWidget({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Hello, $name!',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}

// ═══ مثال على StatefulWidget ═══
class CounterWidget extends StatefulWidget {
  const CounterWidget({Key? key}) : super(key: key);

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Counter: $_counter', style: TextStyle(fontSize: 24)),
        ElevatedButton(
          onPressed: _increment,
          child: Text('Increment'),
        ),
      ],
    );
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 12: الـ Widget Lifecycle في Flutter                             │
// │  Question 12: Widget Lifecycle in Flutter                               │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   الـ Lifecycle هيسلسلة الأحداث للـ Widget من أول ما يتبنى لحد ما يتدمّر.
//
//   للـ StatefulWidget:
//   1. createState() → بيلجع الـ State object
//   2. initState() → أول مرة الـ Widget بيتبني
//   3. didChangeDependencies() → لما الـ dependencies بتتغير
//   4. build() → بيبني الـ Widget tree
//   5. didUpdateWidget() → لما الأب بيبعت widget جديد
//   6. deactivate() → لما الـ Widget بيتدمّر مؤقتاً
//   7. dispose() → لما الـ Widget بيتدمّر نهائياً (Cleanup)
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   The Lifecycle is the sequence of events from creation to destruction.
//
//   For StatefulWidget:
//   1. createState() → Returns the State object
//   2. initState() → First time the Widget is built
//   3. didChangeDependencies() → When dependencies change
//   4. build() → Builds the Widget tree
//   5. didUpdateWidget() → When parent sends a new widget
//   6. deactivate() → When Widget is temporarily removed
//   7. dispose() → When Widget is permanently removed (Cleanup)
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class LifecycleDemo extends StatefulWidget {
  const LifecycleDemo({Key? key}) : super(key: key);

  @override
  _LifecycleDemoState createState() => _LifecycleDemoState();
}

class _LifecycleDemoState extends State<LifecycleDemo> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    print('initState: Widget initialized');
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _counter = 10;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies: Dependencies changed');
  }

  @override
  void didUpdateWidget(LifecycleDemo oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget: Widget updated');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate: Widget deactivated');
  }

  @override
  void dispose() {
    print('dispose: Widget disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build: Building widget');
    return Column(
      children: [
        Text('Counter: $_counter'),
        ElevatedButton(
          onPressed: () => setState(() => _counter++),
          child: Text('Increment'),
        ),
      ],
    );
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 13: BuildContext و متى نستخدمه                                  │
// │  Question 13: BuildContext and When to Use It                           │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   BuildContext هو object بيمثل موقع الـ Widget في الـ Widget tree.
//
//   استخداماته:
//   1. الوصول لـ InheritedWidget ( زي Theme, MediaQuery)
//   2. التنقل بين الشاشات (Navigator)
//   3. إظهار Dialog أو BottomSheet
//   4. الوصول لـ Provider (لو بتستخدمه)
//
//   ملاحظة مهمة: متستخدمش BuildContext بعد dispose() عشان ميقفش الـ App
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   BuildContext represents a Widget's location in the Widget tree.
//
//   Uses:
//   1. Access InheritedWidgets (Theme, MediaQuery, etc.)
//   2. Navigate between screens (Navigator)
//   3. Show Dialogs or BottomSheets
//   4. Access Provider (if using)
//
//   Important: Don't use BuildContext after dispose() to avoid crashes
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class ContextDemo extends StatelessWidget {
  const ContextDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // الوصول لـ Theme
        Text(
          'Theme-dependent text',
          style: Theme.of(context).textTheme.headlineMedium,
        ),

        // الوصول لـ MediaQuery
        Text(
          'Screen width: ${MediaQuery.of(context).size.width}',
        ),

        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NextScreen()),
            );
          },
          child: Text('Go to Next Screen'),
        ),
      ],
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Next Screen')),
      body: Center(
        child: Text('Hello from Next Screen!'),
      ),
    );
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 14: Keys في Flutter                                              │
// │  Question 14: Keys in Flutter (ValueKey, ObjectKey, GlobalKey)          │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Keys بتساعد Flutter يحدد الـ Widgets بشكل أدق.
//
//   أنواع Keys:
//   1. ValueKey: بيستخدم قيمة معينة (مثلاً رقم)
//   2. ObjectKey: بيستخدم Object كامل
//   3. GlobalKey: بيدي للـ Widget معرف فريد عالمي (للوصول لـ State)
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Keys help Flutter identify Widgets more precisely.
//
//   Key Types:
//   1. ValueKey: Uses a specific value (e.g., a number)
//   2. ObjectKey: Uses a whole Object
//   3. GlobalKey: Gives the Widget a globally unique ID (access State)
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class GlobalKeyDemo extends StatefulWidget {
  const GlobalKeyDemo({Key? key}) : super(key: key);

  @override
  _GlobalKeyDemoState createState() => _GlobalKeyDemoState();
}

class _GlobalKeyDemoState extends State<GlobalKeyDemo> {
  final GlobalKey<_AnimatedTextState> textKey = GlobalKey<_AnimatedTextState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AnimatedText(key: textKey),
        ElevatedButton(
          onPressed: () {
            textKey.currentState?.changeColor(Colors.red);
          },
          child: Text('Change Text Color'),
        ),
      ],
    );
  }
}

class _AnimatedText extends StatefulWidget {
  const _AnimatedText({Key? key}) : super(key: key);

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<_AnimatedText> {
  Color _color = Colors.black;

  void changeColor(Color newColor) {
    setState(() {
      _color = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Hello World!',
      style: TextStyle(color: _color, fontSize: 24),
    );
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 15: الـ Layout Widgets في Flutter                                │
// │  Question 15: Layout Widgets in Flutter                                  │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   أهم الـ Layout Widgets:
//   1. Row: ترتيب أفقي
//   2. Column: ترتيب عمودي
//   3. Stack: ترتيب فوق بعض
//   4. Expanded: ملء المساحة المتاحة
//   5. Flexible: مرونة في توزيع المساحة
//   6. Padding: إضافة مسافة حول العناصر
//   7. Center: توسيط العناصر
//   8. Align: محاذاة العناصر
//   9. Wrap: ترتيب عناصر كتير في سطور
//   10. ListView: عرض عناصر في قائمة
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Key Layout Widgets:
//   1. Row: Horizontal arrangement
//   2. Column: Vertical arrangement
//   3. Stack: Overlapping arrangement
//   4. Expanded: Fill available space
//   5. Flexible: Flexible space distribution
//   6. Padding: Add space around elements
//   7. Center: Center elements
//   8. Align: Align elements
//   9. Wrap: Arrange many elements in lines
//   10. ListView: Display elements in a list
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Layout Demo')),
      body: Column(
        children: [
          // Row مع Expanded
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  color: Colors.red,
                  child: Center(child: Text('Expanded 1')),
                ),
              ),
              Container(
                height: 100,
                width: 100,
                color: Colors.blue,
                child: Center(child: Text('Fixed')),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  color: Colors.green,
                  child: Center(child: Text('Expanded 2')),
                ),
              ),
            ],
          ),

          // Stack
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey,
              ),
              Positioned(
                top: 20,
                left: 20,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.yellow,
                  child: Center(child: Text('Positioned')),
                ),
              ),
            ],
          ),

          // Wrap
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
              20,
              (index) => Container(
                width: 80,
                height: 80,
                color: Colors.primaries[index % Colors.primaries.length],
                child: Center(child: Text('$index')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 16: الـ InheritedWidget و متى نستخدمه                           │
// │  Question 16: InheritedWidget and When to Use It                        │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   InheritedWidget بيخلي البيانات متاحة لكل الـ Widgets تحته في الـ Tree.
//   مفيش داعي تبعت البيانات عبر كتير Widgets (Prop Drilling).
//
//   مثال شهير: Theme, MediaQuery, Navigator
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   InheritedWidget makes data available to all Widgets below it.
//   No need to pass data through many Widgets (Prop Drilling).
//
//   Famous examples: Theme, MediaQuery, Navigator
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class UserProvider extends InheritedWidget {
  final String username;

  const UserProvider({
    Key? key,
    required this.username,
    required Widget child,
  }) : super(key: key, child: child);

  static UserProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserProvider>();
  }

  @override
  bool updateShouldNotify(UserProvider oldWidget) {
    return username != oldWidget.username;
  }
}

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final username = UserProvider.of(context)?.username ?? 'Guest';
    return Text('Welcome, $username!');
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 17: الـ Custom Widgets في Flutter                                │
// │  Question 17: Custom Widgets in Flutter                                  │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Custom Widgets بتكتبها عشان:
//   1. إعادة استخدام الكود (DRY Principle)
//   2. ترتيب الكود وجعله أسهل في القراءة
//   3. إنشاء تصميم مخصص
//
//   الأنواع:
//   1. StatelessWidget: ويدجت ثابتة
//   2. StatefulWidget: ويدجت بتتغير
//   3. CustomPainter: للرسم المخصص
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Custom Widgets are used to:
//   1. Reuse code (DRY Principle)
//   2. Organize code and make it readable
//   3. Create custom designs
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// ═══ Custom StatelessWidget ═══
class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const CustomCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.color = Colors.blue,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, size: 48, color: color),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══ Custom StatefulWidget ═══
class CustomCounter extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int>? onChanged;

  const CustomCounter({
    Key? key,
    this.initialValue = 0,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomCounterState createState() => _CustomCounterState();
}

class _CustomCounterState extends State<CustomCounter> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = widget.initialValue;
  }

  void _increment() {
    setState(() => _count++);
    widget.onChanged?.call(_count);
  }

  void _decrement() {
    setState(() => _count--);
    widget.onChanged?.call(_count);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: _decrement,
        ),
        Text(
          '$_count',
          style: TextStyle(fontSize: 24),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: _increment,
        ),
      ],
    );
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 18: الـ Animation في Flutter - دليل شامل                        │
// │  Question 18: Animation in Flutter - Comprehensive Guide                │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Flutter بيقدم 4 أنواع رئيسية للـ Animation:
//
//   ══════════════════════════════════════════════════════════════════════════
//   النوع 1: Implicit Animations (الأبسط - بتتحرك تلقائياً)
//   ══════════════════════════════════════════════════════════════════════════
//
//   الوصف: بتحط Widget و beday Parameters مختلفة، والـ Animation بتحصل تلقائياً
//   مفيش داعي لـ AnimationController
//
//   أشهر الـ Implicit Widgets:
//   ● AnimatedContainer: تغيير الأحجام، الألوان، الحدود
//   ● AnimatedOpacity: التلاشي (Fade in/out)
//   ● AnimatedPositioned: تحريك المواقع
//   ● AnimatedCrossFade: التبديل بين ويدجتات
//   ● AnimatedSwitcher: تبديل المحتوى بأنيميشن
//   ● AnimatedDefaultTextStyle: تغيير الخط والستايل
//   ● AnimatedAlign: تحريك المحاذاة
//   ● AnimatedPadding: تغيير الـ Padding
//   ● TweenAnimationBuilder: Custom implicit animation
//
//   المميزات:
//   ● سهل وسريع في الاستخدام
//   ● مش محتاج AnimationController
//   ● كويس للـ Simple animations
//
//   العيوب:
//   ● مش ممكن تتحكم فيه بشكل كامل
//   ● مش ممكن تعمل pause أو reverse بسهولة
//
//   ══════════════════════════════════════════════════════════════════════════
//   النوع 2: Explicit Animations (الأقوى - تحت تحكم كامل)
//   ══════════════════════════════════════════════════════════════════════════
//
//   الوصف: بتحتاج AnimationController و Tween و CurvedAnimation
//   بدخلك تحكم كامل في الـ Animation (start, stop, reverse, repeat)
//
//   المكونات الأساسية:
//   ● AnimationController: بيتحكم في الـ Timeline
//     - forward(): يبدأ من الأول
//     - reverse(): يرجع من الآخر
//     - repeat(): يكرر
//     - stop(): يوقف
//     - reset(): يرجع لأول
//     - value: القيمة الحالية (من 0.0 لـ 1.0)
//
//   ● Tween: بيحدد البداية والنهاية
//     - Tween<double>(begin: 0, end: 100)
//     - ColorTween(begin: Colors.red, end: Colors.blue)
//     - SizeTween(begin: Size(100, 100), end: Size(200, 200))
//     - IntTween(begin: 0, end: 100)
//     - RelativeRectTween
//
//   ● CurvedAnimation: بيحدد شكل الحركة
//     - Curves.easeIn: بيبدأ ببطء وبي加速
//     - Curves.easeOut: بيبدأ بسرعة وبيبطأ
//     - Curves.easeInOut: بيبدأ وينتهي ببطء
//     - Curves.bounceOut: بيتنطط
//     - Curves.elasticIn: بيتمط
//     - Curves.linear: ثابت
//
//   ● AnimatedBuilder: بيعيد بناء جزء من الـ Widget tree
//   ● AnimatedWidget: ويدجت بتتغير مع الـ Animation
//
//   ══════════════════════════════════════════════════════════════════════════
//   النوع 3: Hero Animations (للانتقال بين الشاشات)
//   ══════════════════════════════════════════════════════════════════════════
//
//   الوصف: بيخلي Widget يتحرك من شاشة لشاشة بشكل سلس
//   زي الصور في Instagram لما تضغط عليها
//
//   المكونات:
//   ● Hero widget: بتحطه على الـ Widget في الشاشتين
//   ● tag: معرف فريد لـ كل Hero (لازم يكون نفس الـ tag في الشاشتين)
//   ● MaterialPageRoute: لازم يكون عشان الـ Hero يشتغل
//
//   ══════════════════════════════════════════════════════════════════════════
//   النوع 4: Staggered Animations (تتابع الـ Animations)
//   ══════════════════════════════════════════════════════════════════════════
//
//   الوصف: بتحط AnimationController واحد و beday كل Animation في وقت معين
//   زي لما عناصر كتير تظهر واحدة ورا التانية
//
//   الطريقة:
//   1. حدد الـ Start و End Time لكل Animation
//   2. استخدم Interval لتحديد التوقيت
//   3. حط كل Animation في Tween منفصل
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Flutter provides 4 main types of Animation:
//
//   ══════════════════════════════════════════════════════════════════════════
//   Type 1: Implicit Animations (Easiest - auto-animate)
//   ══════════════════════════════════════════════════════════════════════════
//
//   Description: Set widget with different parameters, animation happens automatically
//   No AnimationController needed
//
//   Popular Implicit Widgets:
//   ● AnimatedContainer: Change size, color, borders
//   ● AnimatedOpacity: Fade in/out
//   ● AnimatedPositioned: Move positions
//   ● AnimatedCrossFade: Switch between widgets
//   ● AnimatedSwitcher: Switch content with animation
//   ● AnimatedDefaultTextStyle: Change font and style
//   ● AnimatedAlign: Move alignment
//   ● AnimatedPadding: Change padding
//   ● TweenAnimationBuilder: Custom implicit animation
//
//   Pros: Easy and fast to use, no controller needed
//   Cons: Less control, can't pause/reverse easily
//
//   ══════════════════════════════════════════════════════════════════════════
//   Type 2: Explicit Animations (Most powerful - full control)
//   ══════════════════════════════════════════════════════════════════════════
//
//   Components:
//   ● AnimationController: Controls the Timeline
//     - forward(), reverse(), repeat(), stop(), reset()
//     - value: current value (0.0 to 1.0)
//
//   ● Tween: Defines start and end values
//     - Tween<double>, ColorTween, SizeTween, IntTween
//
//   ● CurvedAnimation: Defines motion shape
//     - easeIn, easeOut, easeInOut, bounceOut, elasticIn, linear
//
//   ● AnimatedBuilder: Rebuilds part of widget tree
//   ● AnimatedWidget: Widget that changes with animation
//
//   ══════════════════════════════════════════════════════════════════════════
//   Type 3: Hero Animations (For screen transitions)
//   ══════════════════════════════════════════════════════════════════════════
//
//   Makes a widget move smoothly between screens
//   Like Instagram image zoom
//
//   Components:
//   ● Hero widget: Wrap widget on both screens
//   ● tag: Unique identifier (same on both screens)
//   ● MaterialPageRoute: Required for Hero to work
//
//   ══════════════════════════════════════════════════════════════════════════
//   Type 4: Staggered Animations (Sequential animations)
//   ══════════════════════════════════════════════════════════════════════════
//
//   One AnimationController with multiple animations at different times
//   Like elements appearing one after another
//
//   Steps:
//   1. Define start and end time for each animation
//   2. Use Interval to set timing
//   3. Put each animation in separate Tween
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال 1: Implicit Animation
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// ═══ AnimatedContainer - تغيير الأحجام والألوان ═══
class ImplicitAnimationDemo extends StatefulWidget {
  const ImplicitAnimationDemo({Key? key}) : super(key: key);

  @override
  _ImplicitAnimationDemoState createState() => _ImplicitAnimationDemoState();
}

class _ImplicitAnimationDemoState extends State<ImplicitAnimationDemo> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: _isExpanded ? 200 : 100,
        height: _isExpanded ? 200 : 100,
        decoration: BoxDecoration(
          color: _isExpanded ? Colors.blue : Colors.red,
          borderRadius: BorderRadius.circular(_isExpanded ? 100 : 16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: _isExpanded ? 20 : 8,
              offset: Offset(0, _isExpanded ? 10 : 4),
            ),
          ],
        ),
        curve: Curves.easeInOut,
        child: Center(
          child: Text(
            _isExpanded ? 'Expanded' : 'Tap me',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

// ═══ AnimatedOpacity - التلاشي ═══
class AnimatedOpacityDemo extends StatefulWidget {
  const AnimatedOpacityDemo({Key? key}) : super(key: key);

  @override
  _AnimatedOpacityDemoState createState() => _AnimatedOpacityDemoState();
}

class _AnimatedOpacityDemoState extends State<AnimatedOpacityDemo> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          child: Container(
            width: 200,
            height: 200,
            color: Colors.orange,
            child: Center(
              child: Text('Hello!', style: TextStyle(fontSize: 24)),
            ),
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => setState(() => _visible = !_visible),
          child: Text(_visible ? 'Hide' : 'Show'),
        ),
      ],
    );
  }
}

// ═══ AnimatedSwitcher - تبديل المحتوى ═══
class AnimatedSwitcherDemo extends StatefulWidget {
  const AnimatedSwitcherDemo({Key? key}) : super(key: key);

  @override
  _AnimatedSwitcherDemoState createState() => _AnimatedSwitcherDemoState();
}

class _AnimatedSwitcherDemoState extends State<AnimatedSwitcherDemo> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Text(
            '$_count',
            key: ValueKey<int>(_count),
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => setState(() => _count++),
          child: Text('Increment'),
        ),
      ],
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال 2: Explicit Animation
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// ═══ AnimationController + Tween + AnimatedBuilder ═══
class ExplicitAnimationDemo extends StatefulWidget {
  const ExplicitAnimationDemo({Key? key}) : super(key: key);

  @override
  _ExplicitAnimationDemoState createState() => _ExplicitAnimationDemoState();
}

class _ExplicitAnimationDemoState extends State<ExplicitAnimationDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // ═══ Tween للحجم ═══
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    // ═══ Tween للون ═══
    _colorAnimation = ColorTween(begin: Colors.red, end: Colors.blue).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // ═══ Tween للحركة ═══
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(1.5, 0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: _slideAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: _colorAnimation.value,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'Animated',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال 3: Hero Animation
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// ═══ الشاشة الأولى مع Hero ═══
class HeroListScreen extends StatelessWidget {
  final List<String> items = List.generate(20, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hero List')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Hero(
              tag: 'avatar_$index',
              child: CircleAvatar(
                backgroundColor: Colors.primaries[index % Colors.primaries.length],
                child: Text('${index + 1}'),
              ),
            ),
            title: Text(items[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HeroDetailScreen(
                    index: index,
                    title: items[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ═══ الشاشة التانية مع نفس الـ Hero ═══
class HeroDetailScreen extends StatelessWidget {
  final int index;
  final String title;

  const HeroDetailScreen({Key? key, required this.index, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(title),
              background: Hero(
                tag: 'avatar_$index',
                child: Container(
                  color: Colors.primaries[index % Colors.primaries.length],
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(fontSize: 72, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'This is the detail screen for $title. '
                'The avatar smoothly animated from the list to here!',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال 4: Staggered Animation
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// ═══ عناصر بتظهر واحدة ورا التانية ═══
class StaggeredAnimationDemo extends StatefulWidget {
  const StaggeredAnimationDemo({Key? key}) : super(key: key);

  @override
  _StaggeredAnimationDemoState createState() => _StaggeredAnimationDemoState();
}

class _StaggeredAnimationDemoState extends State<StaggeredAnimationDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // ═══ تحديد توقيت كل Animation ═══
  // كل Animation بيبدأ في وقت وينتهي في وقت
  late Animation<double> _fadeIn1;
  late Animation<double> _fadeIn2;
  late Animation<double> _fadeIn3;
  late Animation<double> _slideIn1;
  late Animation<double> _slideIn2;
  late Animation<double> _slideIn3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );

    // ═══ Fade Animations مع Interval ═══
    // Interval(b, e) بيحدد البداية والنهاية كنسبة من الـ Duration الكلي
    _fadeIn1 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    _fadeIn2 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2, 0.5, curve: Curves.easeIn),
      ),
    );

    _fadeIn3 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.4, 0.7, curve: Curves.easeIn),
      ),
    );

    // ═══ Slide Animations مع Interval ═══
    _slideIn1 = Tween<double>(begin: 50, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    _slideIn2 = Tween<double>(begin: 50, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2, 0.5, curve: Curves.easeOut),
      ),
    );

    _slideIn3 = Tween<double>(begin: 50, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.4, 0.7, curve: Curves.easeOut),
      ),
    );

    // ═══ شغّل الـ Animation ═══
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Staggered Animation')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ═══ العنصر الأول ═══
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeIn1.value,
                  child: Transform.translate(
                    offset: Offset(0, _slideIn1.value),
                    child: Container(
                      width: 200,
                      height: 60,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text('Item 1', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                );
              },
            ),

            // ═══ العنصر التاني ═══
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeIn2.value,
                  child: Transform.translate(
                    offset: Offset(0, _slideIn2.value),
                    child: Container(
                      width: 200,
                      height: 60,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text('Item 2', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                );
              },
            ),

            // ═══ العنصر التالت ═══
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeIn3.value,
                  child: Transform.translate(
                    offset: Offset(0, _slideIn3.value),
                    child: Container(
                      width: 200,
                      height: 60,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text('Item 3', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                _controller.reset();
                _controller.forward();
              },
              child: Text('Replay Animation'),
            ),
          ],
        ),
      ),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال 5: Custom Page Transition
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// ═══ Custom Page Route Animation ═══
class FadeSlideRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeSlideRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            );

            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0)
                    .animate(curvedAnimation),
                child: child,
              ),
            );
          },
          transitionDuration: Duration(milliseconds: 500),
        );
}

// ═══ استخدام الـ Custom Route ═══
// Navigator.push(context, FadeSlideRoute(page: NextScreen()));


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 19: الـ Responsive Design في Flutter                             │
// │  Question 19: Responsive Design in Flutter                               │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Responsive Design يعني التصميم يشتغل على كل الأحجام (موبايل، تابلت، ويب).
//
//   الطرق:
//   1. MediaQuery: للوصول لأبعاد الشاشة
//   2. LayoutBuilder: لبناء ويدجت على حسب المساحة المتاحة
//   3. OrientationBuilder: للتعامل مع تغير الاتجاه
//   4. Responsive packages: زي flutter_screenutil
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Responsive Design means the design works on all screen sizes.
//
//   Approaches:
//   1. MediaQuery: Access screen dimensions
//   2. LayoutBuilder: Build based on available space
//   3. OrientationBuilder: Handle orientation changes
//   4. Responsive packages: Like flutter_screenutil
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return _buildWideLayout();
        } else {
          return _buildNarrowLayout();
        }
      },
    );
  }

  Widget _buildWideLayout() {
    return Row(
      children: [
        Expanded(child: _buildMenuItem('Item 1')),
        Expanded(child: _buildMenuItem('Item 2')),
        Expanded(child: _buildMenuItem('Item 3')),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    return Column(
      children: [
        _buildMenuItem('Item 1'),
        _buildMenuItem('Item 2'),
        _buildMenuItem('Item 3'),
      ],
    );
  }

  Widget _buildMenuItem(String title) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.item),
        title: Text(title),
      ),
    );
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 20: الـ Platform Channels في Flutter                             │
// │  Question 20: Platform Channels in Flutter                               │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Platform Channels بتخلي Flutter يتكلم مع الكود الأصلي (Native).
//
//   الأنواع:
//   1. MethodChannel: استدعاء methods من Native
//   2. EventChannel: Stream من Native لـ Flutter
//   3. BasicMessageChannel: إرسال رسائل بسيطة
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Platform Channels allow Flutter to communicate with native code.
//
//   Types:
//   1. MethodChannel: Call methods from native
//   2. EventChannel: Stream from native to Flutter
//   3. BasicMessageChannel: Send simple messages
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class PlatformChannelDemo {
  static const MethodChannel _channel =
      MethodChannel('com.example.myapp/battery');

  Future<int> getBatteryLevel() async {
    try {
      final int level = await _channel.invokeMethod('getBatteryLevel');
      return level;
    } on PlatformException catch (e) {
      print('Failed to get battery level: ${e.message}');
      return -1;
    }
  }
}


// ██████████████████████████████████████████████████████████████████████████████
//                              PART 3
//                   SOLID Principles - مبادئ SOLID
// ██████████████████████████████████████████████████████████████████████████████


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 21: SRP - Single Responsibility Principle                       │
// │  Question 21: Single Responsibility Principle                           │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   كل كلاس لازم يكون عنده مسؤولية واحدة بس.
//
//   ليه مهم؟
//   1. الكود يبقى أسهل في الصيانة
//   2. لو في مشكلة، هتعدل في مكان واحد بس
//   3. أسهل في الاختبار
//
//   ❌ مثال غلط:
//   class UserManager {
//     void createUser(String name) { ... }
//     void sendEmail(String email) { ... }
//     void saveToDatabase() { ... }
//   }
//
//   ✅ مثال صح:
//   class UserService { void createUser(User user) { ... } }
//   class EmailService { void sendEmail(String email) { ... } }
//   class DatabaseService { void save(User user) { ... } }
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Each class should have only ONE responsibility.
//
//   Why it matters:
//   1. Code is easier to maintain
//   2. If there's a bug, you only change one place
//   3. Easier to test
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});
}

// مسؤول عن حفظ المستخدمين
class UserRepository {
  Future<void> save(User user) async {
    print('Saving user: ${user.name}');
  }

  Future<User?> findById(int id) async {
    return null;
  }
}

// مسؤول عن إرسال الإيميلات
class EmailService {
  Future<void> sendWelcomeEmail(User user) async {
    print('Sending welcome email to: ${user.email}');
  }
}

// مسؤول عن السجلات
class Logger {
  void log(String message) {
    print('[LOG]: $message');
  }
}

// مسؤول عن الـ Business Logic
class UserService {
  final UserRepository _repository;
  final EmailService _emailService;
  final Logger _logger;

  UserService({
    required UserRepository repository,
    required EmailService emailService,
    required Logger logger,
  })  : _repository = repository,
        _emailService = emailService,
        _logger = logger;

  Future<void> createUser(String name, String email) async {
    _logger.log('Creating user: $name');
    final user = User(name: name, email: email);
    await _repository.save(user);
    await _emailService.sendWelcomeEmail(user);
    _logger.log('User created successfully');
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 22: OCP - Open/Closed Principle                                 │
// │  Question 22: Open/Closed Principle                                     │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   الكلاسات المفتوحة للتوسيع (Extension) بس مقفولة للتعديل (Modification).
//
//   يعني إيه؟
//   - لما تحتاج تضيف ميزة جديدة، اكتب كود جديد
//   - مtedish الكود القديم
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Classes should be open for extension but closed for modification.
//
//   Meaning:
//   - When adding a feature, write new code
//   - Don't modify existing code
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

abstract class NotificationService {
  Future<void> send(String message);
}

class EmailNotification implements NotificationService {
  @override
  Future<void> send(String message) async {
    print('Sending email: $message');
  }
}

class SMSNotification implements NotificationService {
  @override
  Future<void> send(String message) async {
    print('Sending SMS: $message');
  }
}

class PushNotification implements NotificationService {
  @override
  Future<void> send(String message) async {
    print('Sending push notification: $message');
  }
}

class NotificationManager {
  final List<NotificationService> _services;

  NotificationManager(this._services);

  Future<void> notifyAll(String message) async {
    for (var service in _services) {
      await service.send(message);
    }
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 23: LSP - Liskov Substitution Principle                         │
// │  Question 23: Liskov Substitution Principle                             │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   الكائنات من نفس النوع لازم يقدروا يتعوضوا بغيرهم من غير ما يأثروا.
//
//   يعني إيه؟
//   - الابناء (Subclasses) لازم يقدروا يستبدلوا الأب (Parent)
//   - مtedish أي توقع من الأب
//
//   ❌ مثال غلط:
//   class Bird { void fly() { ... } }
//   class Penguin extends Bird {
//     void fly() { throw Exception('Penguins can\'t fly!'); }
//   }
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Objects of a supertype should be replaceable with objects of a subtype
//   without affecting program correctness.
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

abstract class Shape {
  double get area;
  double get perimeter;
}

class Circle implements Shape {
  final double radius;
  Circle(this.radius);

  @override
  double get area => 3.14159 * radius * radius;

  @override
  double get perimeter => 2 * 3.14159 * radius;
}

class Rectangle implements Shape {
  final double width;
  final double height;
  Rectangle(this.width, this.height);

  @override
  double get area => width * height;

  @override
  double get perimeter => 2 * (width + height);
}

void printShapeInfo(Shape shape) {
  print('Area: ${shape.area}');
  print('Perimeter: ${shape.perimeter}');
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 24: ISP - Interface Segregation Principle                       │
// │  Question 24: Interface Segregation Principle                           │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   الكلاسات مش المفروض تضطر ت่าน واجهات مش محتاجينها.
//
//   ❌ مثال غلط:
//   interface Worker {
//     void work();
//     void eat();
//     void sleep();
//   }
//   class Robot implements Worker {
//     void work() { ... }
//     void eat() { throw Exception('Robots don\'t eat'); }
//     void sleep() { throw Exception('Robots don\'t sleep'); }
//   }
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Classes shouldn't be forced to implement interfaces they don't use.
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

abstract class Workable {
  void work();
}

abstract class Eatable {
  void eat();
}

abstract class Sleepable {
  void sleep();
}

class Robot implements Workable {
  @override
  void work() {
    print('Robot is working');
  }
}

class Human implements Workable, Eatable, Sleepable {
  @override
  void work() {
    print('Human is working');
  }

  @override
  void eat() {
    print('Human is eating');
  }

  @override
  void sleep() {
    print('Human is sleeping');
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 25: DIP - Dependency Inversion Principle                        │
// │  Question 25: Dependency Inversion Principle                            │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   الوحدات العالية مش المفروض تعتمد على الوحدات المنخفضة.
//   الاتنين المفروض يعتمدوا على الـ Abstractions.
//
//   يعني إيه؟
//   1. استخدم الـ Interfaces بدل الـ Concrete Classes
//   2. استخدم Dependency Injection
//   3. ده بيديك مرونة في تغيير الـ Implementation
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   High-level modules shouldn't depend on low-level modules.
//   Both should depend on abstractions.
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

abstract class LoggerAbstract {
  void log(String message);
}

class ConsoleLogger implements LoggerAbstract {
  @override
  void log(String message) {
    print('[Console]: $message');
  }
}

class FileLogger implements LoggerAbstract {
  @override
  void log(String message) {
    print('[File]: $message');
  }
}

class ApiService {
  final LoggerAbstract _logger;

  ApiService(this._logger);  // ✅ Dependency Injection

  Future<void> fetchData() async {
    _logger.log('Fetching data...');
    // كود الـ API
    _logger.log('Data fetched successfully');
  }
}


// ██████████████████████████████████████████████████████████████████████████████
//                              PART 4
//                   State Management - إدارة الحالة
// ██████████████████████████████████████████████████████████████████████████████


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 26: مقارنة بين State Management Solutions                       │
// │  Question 26: Comparison between State Management Solutions             │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   1. setState(): للحالة المحلية البسيطة
//      - بسيط ومش محتاج مكتبات
//      - مش مناسب للحالة المعقدة
//
//   2. Provider: الحل الأساسي والأسهل
//      - سهل في الاستخدام
//      - كويس للمشاريع الصغيرة والمتوسطة
//
//   3. Riverpod: تطوير على Provider
//      - Compile-time safety
//      - أسهل في الاختبار
//
//   4. Bloc/Cubit: نمط معين للحالة
//      - منظم وواضح
//      - كويس للمشاريع الكبيرة
//
//   5. GetX: مكتبة شاملة
//      - سهل وسريع
//      - بيجمع كل حاجة في مكتبة واحدة
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   1. setState(): For simple local state
//   2. Provider: Basic and easiest solution
//   3. Riverpod: Evolution of Provider
//   4. Bloc/Cubit: Pattern for state
//   5. GetX: All-in-one library
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class CounterProvider extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }

  void reset() {
    _count = 0;
    notifyListeners();
  }
}

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Provider Counter')),
      body: Center(
        child: Consumer<CounterProvider>(
          builder: (context, counter, child) {
            return Text(
              'Count: ${counter.count}',
              style: TextStyle(fontSize: 48),
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'increment',
            onPressed: () => context.read<CounterProvider>().increment(),
            child: Icon(Icons.add),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'decrement',
            onPressed: () => context.read<CounterProvider>().decrement(),
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 27: متى نستخدم setState() vs Provider                          │
// │  Question 27: When to use setState() vs Provider                        │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   استخدم setState() عندما:
//   1. الحالة محلية للويدجت بس
//   2. البساطة مهمة (مشروع صغير)
//   3. مفيش تعقيد في الـ State
//
//   استخدم Provider عندما:
//   1. الحالة مشتركة بين كتير ويدجتات
//   2. محتاجين وصول من أماكن كتير
//   3. المشروع كبير ومحترم
//   4. محتاجين الاختبار بسهولة
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Use setState() when: state is local, simple project, no complexity
//   Use Provider when: state is shared, many access points, large project
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 28: Bloc Pattern في Flutter                                     │
// │  Question 28: Bloc Pattern in Flutter                                   │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Bloc (Business Logic Component) نمط بيفرقي بين الـ UI و الـ Logic.
//
//   المكونات:
//   1. Events: الأحداث اللي بتحصل (زي الأزرار)
//   2. States: الحالات المختلفة للـ UI
//   3. Bloc: بيتحول بين الـ States بناءً على الـ Events
//
//   المميزات:
//   - منظم وواضح
//   - سهل في الاختبار
//   - بيستخدم Streams (reactive)
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Bloc separates UI from Logic.
//   Components: Events, States, Bloc
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// Events
abstract class CounterEvent {}
class Increment extends CounterEvent {}
class Decrement extends CounterEvent {}
class Reset extends CounterEvent {}

// States
class CounterState {
  final int count;
  final bool isLoading;

  CounterState({required this.count, this.isLoading = false});

  CounterState copyWith({int? count, bool? isLoading}) {
    return CounterState(
      count: count ?? this.count,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// Bloc
class CounterBloc {
  final _stateController = StreamController<CounterState>.broadcast();
  final _eventController = StreamController<CounterEvent>();

  Stream<CounterState> get state => _stateController.stream;
  Sink<CounterEvent> get event => _eventController.sink;

  CounterBloc() {
    _eventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    final currentState = _stateController.value ?? CounterState(count: 0);

    if (event is Increment) {
      _stateController.add(
        currentState.copyWith(count: currentState.count + 1),
      );
    } else if (event is Decrement) {
      _stateController.add(
        currentState.copyWith(count: currentState.count - 1),
      );
    } else if (event is Reset) {
      _stateController.add(CounterState(count: 0));
    }
  }

  void dispose() {
    _stateController.close();
    _eventController.close();
  }
}


// ██████████████████████████████████████████████████████████████████████████████
//                              PART 5
//                        Navigation - الملاحة
// ██████████████████████████████████████████████████████████████████████████████


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 29: Navigator 1.0 vs Navigator 2.0                              │
// │  Question 29: Navigator 1.0 vs Navigator 2.0                            │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Navigator 1.0 (الطريقة القديمة):
//   - بسيط وسهل
//   - بيستخدم Stack
//   - push و pop
//   - مش مناسب للـ Web
//
//   Navigator 2.0 (Declarative):
//   - بيستخدم الـ Router
//   - مناسب للـ Web
//   - أصعب في الاستخدام بس أقوى
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Navigator 1.0: Simple, uses Stack, not for Web
//   Navigator 2.0: Uses Router, suitable for Web, more powerful
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class Navigator1Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Navigator 1.0')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(message: 'Hello!'),
              ),
            );
          },
          child: Text('Go to Detail'),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String message;

  const DetailScreen({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message, style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Data from Detail');
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 30: Routes في Flutter                                            │
// │  Question 30: Routes in Flutter                                         │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   في طرق كتير للـ Routing في Flutter:
//
//   1. Named Routes:
//      Navigator.pushNamed(context, '/detail');
//
//   2. Route Generator:
//      على حسب الـ Route name
//
//   3. On-Generate Route:
//      للـ Routes المعقدة
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Ways to handle Routing:
//   1. Named Routes
//   2. Route Generator
//   3. On-Generate Route
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/detail':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => DetailScreen(message: args),
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text('Error: Route not found')),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/detail',
              arguments: 'Hello from Home',
            );
          },
          child: Text('Go to Detail'),
        ),
      ),
    );
  }
}


// ██████████████████████████████████████████████████████████████████████████████
//                              PART 6
//                         Performance - الأداء
// ██████████████████████████████████████████████████████████████████████████████


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 31: تحسين أداء Flutter Apps                                     │
// │  Question 31: Improving Flutter App Performance                         │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   في كتير طرق تحس أداء الـ App:
//
//   1. استخدام const Widgets
//   2. تجنب إعادة البناء غير الضرورية
//   3. استخدام ListView.builder بدل ListView
//   4. تحسين الصور (Compression)
//   5. استخدام الـ Code Splitting
//   6. تقليل الـ Overdraw
//   7. استخدام الـ RepaintBoundary
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Ways to improve performance:
//   1. Use const Widgets
//   2. Avoid unnecessary rebuilds
//   3. Use ListView.builder instead of ListView
//   4. Optimize images
//   5. Use Code Splitting
//   6. Reduce Overdraw
//   7. Use RepaintBoundary
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class PerformanceDemo extends StatelessWidget {
  static const _textStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ✅ GOOD: const widget
        const Text('Hello', style: TextStyle(fontSize: 24)),

        // ❌ BAD: non-const widget
        Text('World', style: TextStyle(fontSize: 24)),
      ],
    );
  }
}

// ═══ ListView.builder ═══
class OptimizedList extends StatelessWidget {
  final List<String> items;

  const OptimizedList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ✅ GOOD: ListView.builder - بيبني العناصر بس وقت الحاجة
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index]),
        );
      },
    );

    // ❌ BAD: ListView العادي - بيبني كل العناصر مرة واحدة
    // return ListView(
    //   children: items.map((item) => ListTile(title: Text(item))).toList(),
    // );
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 32: الـ const Constructor في Flutter                            │
// │  Question 32: const Constructor in Flutter                              │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   الـ const Constructor بيحسن الأداء عن طريق:
//   1. تجنب إعادة إنشاء الـ Widget كل مرة
//   2. تخزين الـ Widget مرة واحدة بس في الـ Memory
//   3. مقارنة الأخطاء (Compile-time)
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   const Constructor improves performance by:
//   1. Avoiding recreating the Widget every time
//   2. Storing the Widget once in Memory
//   3. Compile-time comparison
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 33: الـ RepaintBoundary في Flutter                              │
// │  Question 33: RepaintBoundary in Flutter                                │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   الـ RepaintBoundary بيحدد منطقة معينة على الشاشة عشان:
//   1. يمنع إعادة رسم الـ Widget غير المتأثر
//   2. يحسن الأداء عن طريق تقليل الـ Overdraw
//   3. يحسن الـ Animation performance
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   RepaintBoundary defines a specific area to:
//   1. Prevent repainting unaffected Widgets
//   2. Improve performance by reducing Overdraw
//   3. Improve Animation performance
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


// ██████████████████████████████████████████████████████████████████████████████
//                              PART 7
//                          Testing - الاختبار
// ██████████████████████████████████████████████████████████████████████████████


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 34: أنواع الاختبارات في Flutter                                  │
// │  Question 34: Types of Testing in Flutter                               │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Flutter بيقدم 3 أنواع رئيسية من الاختبارات:
//
//   1. Unit Tests: اختبار الدوال والكلاسات
//      - أسرع أنواع الاختبارات
//      - بتشتغل على جزء واحد من الكود
//
//   2. Widget Tests: اختبار الـ Widgets
//      - أبطأ شوية من Unit Tests
//      - بتشتغل على واجهة المستخدم
//
//   3. Integration Tests: اختبار التطبيق كله
//      - أبطأ أنواع الاختبارات
//      - بتشتغل على التطبيق الحقيقي
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   1. Unit Tests: Test functions and classes (fastest)
//   2. Widget Tests: Test user interface (slower)
//   3. Integration Tests: Test entire app (slowest)
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 35: الـ Mocking في الاختبارات                                    │
// │  Question 35: Mocking in Tests                                          │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Mocking هو إنشاء objects وهمية تمثل objects حقيقية في الاختبارات.
//
//   ليه نستخدمه؟
//   1. عزل الكود اللي بنتختبره
//   2. تجنب الاتصال بالخادم الحقيقي
//   3. اختبار الحالات المختلفة بسهولة
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Mocking is creating fake objects for tests.
//   Benefits: Isolate code, avoid real server, test easily.
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


// ██████████████████████████████████████████████████████████████████████████████
//                              PART 8
//               Common Interview Questions - أسئلة شائعة
// ██████████████████████████████████████████████████████████████████████████████


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 36: إيه الفرق بين Flutter و React Native؟                       │
// │  Question 36: Difference between Flutter and React Native?              │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Flutter:
//   - من Google
//   - بيستخدم Dart
//   - Rendering من الصفر (أداء أحسن)
//   - أصعب في التعلم
//
//   React Native:
//   - من Facebook
//   - بيستخدم JavaScript
//   - بيستخدم Native components
//   - أسهل في التعلم (لو عارف JavaScript)
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Flutter: From Google, uses Dart, custom rendering, better performance
//   React Native: From Facebook, uses JavaScript, uses Native components
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 37: الـ Hot Reload و الـ Hot Restart                            │
// │  Question 37: Hot Reload vs Hot Restart                                 │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Hot Reload:
//   - بيحط التغييرات من غير restart كامل
//   - بيحافظ على الـ State
//   - أسرع في التطوير
//
//   Hot Restart:
//   - بيعمل restart كامل للـ App
//   - بيفقد الـ State
//   - أبطأ شوية
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Hot Reload: Applies changes without full restart, preserves State
//   Hot Restart: Full app restart, loses State
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 38: الـ DevTools في Flutter                                      │
// │  Question 38: DevTools in Flutter                                       │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   DevTools هي أدوات التطوير المدمجة في Flutter.
//
//   المكونات:
//   1. Performance: عرض أداء الـ App
//   2. Inspector: فحص الـ Widget tree
//   3. Network: مراقبة الـ API calls
//   4. Logging: عرض السجلات
//   5. Memory: مراقبة الـ Memory usage
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   DevTools are built-in development tools with components:
//   Performance, Inspector, Network, Logging, Memory
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 39: الـ Platform Channels                                       │
// │  Question 39: Platform Channels                                         │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Platform Channels بتخلي Flutter يتكلم مع الكود الأصلي (Native).
//
//   الأنواع:
//   1. MethodChannel: استدعاء methods من Native
//   2. EventChannel: Stream من Native لـ Flutter
//   3. BasicMessageChannel: إرسال رسائل بسيطة
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Platform Channels allow Flutter to communicate with native code.
//   Types: MethodChannel, EventChannel, BasicMessageChannel
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 40: الـ Code Splitting في Flutter                                │
// │  Question 40: Code Splitting in Flutter                                  │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Code Splitting هو تقسيم الـ Code لأجزاء أصغر عشان:
//   1. يحسن أداء التحميل
//   2. يقلل حجم الـ App
//   3. يحسن الـ User Experience
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Code Splitting divides code into smaller chunks to:
//   1. Improve loading performance
//   2. Reduce app size
//   3. Improve user experience
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


// ██████████████████████████████████████████████████████████████████████████████
//                              PART 9
//                    Advanced Topics - مواضيع متقدمة
// ██████████████████████████████████████████████████████████████████████████████


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 41: الـ Isolates في Dart                                        │
// │  Question 41: Isolates in Dart                                          │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Isolates بتديك إمكانية تشغيل كود في الخلفية من غير ما تأثر على الـ UI.
//
//   كل Isolate ليه memory و thread مستقل.
//
//   استخداماتها:
//   1. Heavy computations
//   2. File processing
//   3. Network requests
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Isolates allow running code in background without affecting UI.
//   Each Isolate has its own memory and thread.
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'dart:isolate';

Future<int> heavyComputation(int number) async {
  return await Isolate.run(() {
    int result = 0;
    for (int i = 0; i < number; i++) {
      result += i;
    }
    return result;
  });
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 42: الـ FFI في Dart                                              │
// │  Question 42: FFI in Dart                                               │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   FFI (Foreign Function Interface) بتخلي Dart يتكلم مع كود C/C++.
//
//   استخداماتها:
//   1. استخدام مكتبات C الموجودة
//   2. كود عايز أداء عالي
//   3. التفاعل مع System APIs
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   FFI allows Dart to communicate with C/C++ code.
//   Use cases: C libraries, performance-critical code, system APIs
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 43: الـ Code Generation في Dart                                  │
// │  Question 43: Code Generation in Dart                                   │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Code Generation بيولّد كود تلقائياً باستخدام Annotations.
//
//   الأدوات الشهيرة:
//   1. json_serializable: لـ JSON serialization
//   2. freezed: للكلاسات الثابتة
//   3. build_runner: لتشغيل الـ Code generation
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Code Generation generates code automatically using annotations.
//   Tools: json_serializable, freezed, build_runner
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 44: الـ Concurrency في Dart                                      │
// │  Question 44: Concurrency in Dart                                       │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Dart بيستخدم event loop مع Isolates للـ parallelism.
//
//   المفاهيم:
//   1. Future: نتيجة مؤجلة
//   2. Stream: سلسلة أحداث asynchronous
//   3. Isolate: memory و thread مستقل
//   4. async/await: syntax sugar للـ async code
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Dart uses single-threaded event loop with Isolates for parallelism.
//   Concepts: Future, Stream, Isolate, async/await
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 45: الـ Memory Management في Dart                                │
// │  Question 45: Memory Management in Dart                                 │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Dart بيستخدم automatic memory management مع garbage collection.
//
//   المفاهيم:
//   1. Stack: المتغيرات المحلية (وصول سريع)
//   2. Heap: الـ Objects (تخصيص ديناميكي)
//   3. Garbage Collector: تنظيف الذاكرة تلقائياً
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Dart uses automatic memory management with garbage collection.
//   Concepts: Stack, Heap, Garbage Collector
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


// ██████████████████████████████████████████████████████████████████████████████
//                              PART 10
//              Additional Questions - أسئلة إضافية مهمة
// ██████████████████████████████████████████████████████████████████████████████


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 46: الفرق بين Widget و Element و RenderObject                   │
// │  Question 46: Widget vs Element vs RenderObject                         │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   1. Widget: وصف للـ UI (زي Blueprint)
//      - خفيف ومؤقت
//      - ممكن يتعمله reuse
//
//   2. Element: instantiation of the Widget
//      - ثابت في الـ Tree
//      - بيتحكم في الـ Lifecycle
//
//   3. RenderObject: بيتحكم في الـ Layout والـ Paint
//      - بيتحمل الأداء
//      - بيتحكم في الأحجام والمواقع
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   1. Widget: UI description (Blueprint)
//   2. Element: Widget instance, controls Lifecycle
//   3. RenderObject: Handles Layout and Paint
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 47: الـ Keys في Flutter ومتى نستخدمها                           │
// │  Question 47: Keys in Flutter and When to Use Them                      │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Keys بتساعد Flutter يحدد الـ Widgets بشكل أدق.
//
//   الأنواع:
//   1. ValueKey: بيستخدم قيمة معينة
//   2. ObjectKey: بيستخدم Object كامل
//   3. GlobalKey: معرف فريد عالمي
//   4. UniqueKey: دائماً فريد
//
//   متى نستخدمها:
//   - لما الـ Widgets محتاجة تحافظ على الـ State
//   - لما بترتب عناصر في قائمة
//   - لما بتستخدم AnimatedSwitcher
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Keys help Flutter identify Widgets precisely.
//   Types: ValueKey, ObjectKey, GlobalKey, UniqueKey
//   Use: maintaining State, reordering lists, AnimatedSwitcher
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 48: الـ Ticker و الـ vsync                                       │
// │  Question 48: Ticker and vsync                                          │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Ticker: Object بينادي على callbacks كل frame.
//   - بيستخدم مع AnimationController
//   - ممكن يتوقف ويكمل
//
//   vsync: Vertical Synchronization
//   - بيمنع screen tearing
//   - بيربط بـ display refresh rate (60fps)
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Ticker: Fires callbacks every frame, used by AnimationController
//   vsync: Prevents screen tearing, syncs with display refresh rate
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 49: الـ Slivers في Flutter                                       │
// │  Question 49: Slivers in Flutter                                        │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Slivers هي مناطق scrollable داخل scrollable parent.
//
//   الأنواع:
//   1. SliverList: قائمة عناصر
//   2. SliverGrid: تخطيط grid
//   3. SliverAppBar: app bar بيتحرك مع الـ Scroll
//   4. SliverToBoxAdapter: ويدجت عادية في sliver
//
//   المميزات:
//   - Lazy loading (بيبني العناصر الظاهرة بس)
//   - أداء أحسن للقوائم الطويلة
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Slivers are scrollable areas within a scrollable parent.
//   Types: SliverList, SliverGrid, SliverAppBar, SliverToBoxAdapter
//   Benefits: Lazy loading, better performance for long lists
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class SliverDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          floating: true,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Sliver Demo'),
            background: Image.network(
              'https://picsum.photos/400/200',
              fit: BoxFit.cover,
            ),
          ),
        ),

        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                color: Colors.primaries[index % Colors.primaries.length],
                child: Center(child: Text('$index')),
              );
            },
            childCount: 20,
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ListTile(
                leading: Icon(Icons.item),
                title: Text('Item $index'),
              );
            },
            childCount: 100,
          ),
        ),
      ],
    );
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 50: نصائح مهمة للإنترفيو                                         │
// │  Question 50: Important Tips for Interviews                             │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   1. اشرح Thought Process:
//      - قبل ما تكتب كود، اشرح فكرتك
//      - اسأل أسئلة توضيحية
//      - ابدأ بالحل الأبسط
//
//   2. اكتب Clean Code:
//      - Names meaningful
//      - Functions small
//      - Comments when needed
//
//   3. اعرف SOLID:
//      - كل مبدأ بشرح وبمثال
//      - متى تستخدمه في Flutter
//
//   4. اعرف State Management:
//      - الفرق بين الحلول
//      - متى تستخدم كل واحد
//
//   5. Practice:
//      - اetCode على LeetCode
//      - اعمل Mini Projects
//      - اقرأ Flutter Documentation
//
//   6. اسأل أسئلة:
//      - عن الفريق
//      - عن المشروع
//      - عن التكنولوجيات المستخدمة
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   1. Explain Thought Process: Think aloud, ask questions, start simple
//   2. Write Clean Code: Meaningful names, small functions
//   3. Know SOLID: Each principle with examples
//   4. Know State Management: Differences and when to use each
//   5. Practice: LeetCode, Mini Projects, Documentation
//   6. Ask Questions: About team, project, technologies
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


// ██████████████████████████████████████████████████████████████████████████████
//                              PART 10
//                Animation Deep Dive - الأنيميشن بشكل تفصيلي
// ██████████████████████████████████████████████████████████████████████████████


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 51: شرح أنواع Curves في Flutter مع أمثلة                        │
// │  Question 51: Curves in Flutter with Examples                           │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   الـ Curves بتحدد شكل الحركة في الـ Animation.
//
//   أشهر الـ Curves:
//   ● Curves.linear: حركة ثابتة بدون تسارع أو تباطؤ
//   ● Curves.easeIn: بيبدأ ببطء وبي加速
//   ● Curves.easeOut: بيبدأ بسرعة وبيبطأ
//   ● Curves.easeInOut: بيبدأ وينتهي ببطء (الأشهر)
//   ● Curves.bounceOut: بيتنطط في الآخر
//   ● Curves.elasticOut: بيتمط زي الـ Spring
//   ● Curves.easeInBack: بيتحرك لورا شوية الأول
//   ● Curves.easeOutBack: بيتحرك لورا شوية في الآخر
//   ● Curves.slowMiddle: بيبطأ في النص
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Curves define the motion shape in Animation.
//
//   Popular Curves:
//   ● Curves.linear: Constant speed
//   ● Curves.easeIn: Starts slow, speeds up
//   ● Curves.easeOut: Starts fast, slows down
//   ● Curves.easeInOut: Starts and ends slow (Most popular)
//   ● Curves.bounceOut: Bounces at the end
//   ● Curves.elasticOut: Springs like a rubber band
//   ● Curves.easeInBack: Moves backward slightly first
//   ● Curves.easeOutBack: Moves backward slightly at end
//   ● Curves.slowMiddle: Slows in the middle
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class CurvesDemo extends StatefulWidget {
  const CurvesDemo({Key? key}) : super(key: key);

  @override
  _CurvesDemoState createState() => _CurvesDemoState();
}

class _CurvesDemoState extends State<CurvesDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _selectedCurve = 0;

  final List<Curve> _curves = [
    Curves.linear,
    Curves.easeIn,
    Curves.easeOut,
    Curves.easeInOut,
    Curves.bounceOut,
    Curves.elasticOut,
  ];

  final List<String> _curveNames = [
    'linear',
    'easeIn',
    'easeOut',
    'easeInOut',
    'bounceOut',
    'elasticOut',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Curves Demo')),
      body: Column(
        children: [
          // ═══ اختيار الـ Curve ═══
          Wrap(
            spacing: 8,
            children: List.generate(_curves.length, (index) {
              return ChoiceChip(
                label: Text(_curveNames[index]),
                selected: _selectedCurve == index,
                onSelected: (selected) {
                  setState(() => _selectedCurve = index);
                  _controller.reset();
                  _controller.repeat();
                },
              );
            }),
          ),

          SizedBox(height: 32),

          // ═══ عرض الـ Animation ═══
          Expanded(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final curvedAnimation = CurvedAnimation(
                  parent: _controller,
                  curve: _curves[_selectedCurve],
                );

                return Stack(
                  children: [
                    // ═══ خلفية ═══
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.grey[200],
                        child: Center(
                          child: Text(
                            _curveNames[_selectedCurve],
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // ═══ المربع المتحرك ═══
                    Positioned(
                      top: MediaQuery.of(context).size.height / 2 - 25,
                      left: curvedAnimation.value *
                          (MediaQuery.of(context).size.width - 50),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 52: AnimatedBuilder vs AnimatedWidget                            │
// │  Question 52: AnimatedBuilder vs AnimatedWidget                         │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   AnimatedBuilder:
//   ● بيعدّي الـ Animation كـ parameter
//   ● بيعيد بناء الـ Widget tree كل مرة
//   ● أسرع لما الـ Animation بيتغير كتير
//   ● بيستخدم مع AnimatedController
//
//   AnimatedWidget:
//   ● بيوارث من AnimatedWidget
//   ● بيعمل rebuild تلقائياً
//   ● أسهل في القراءة
//   ● أحسن لما الـ Widget بسيط
//
//   الفرق الرئيسي:
//   ● AnimatedBuilder: بيتحكم في إيه اللي بيعمل rebuild
//   ● AnimatedWidget: بيعمل rebuild لكل الـ Widget
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   AnimatedBuilder:
//   ● Passes animation as parameter
//   ● Rebuilds widget tree each time
//   ● Faster when animation changes frequently
//   ● Used with AnimationController
//
//   AnimatedWidget:
//   ● Inherits from AnimatedWidget
//   ● Auto rebuilds
//   ● Easier to read
//   ● Better for simple widgets
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// ═══ AnimatedBuilder ═══
class AnimatedBuilderDemo extends StatefulWidget {
  const AnimatedBuilderDemo({Key? key}) : super(key: key);

  @override
  _AnimatedBuilderDemoState createState() => _AnimatedBuilderDemoState();
}

class _AnimatedBuilderDemoState extends State<AnimatedBuilderDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // ═══ بيعيد بناء الـ Container بس ═══
        return Container(
          width: 100 + (_controller.value * 100),
          height: 100 + (_controller.value * 100),
          color: Colors.blue,
          child: child, // ═══ الـ Child مش بيعمل rebuild ═══
        );
      },
      child: Center(
        child: Text('Built once', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

// ═══ AnimatedWidget ═══
class RotatingWidget extends AnimatedWidget {
  const RotatingWidget({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.rotate(
      angle: animation.value * 2 * 3.14159,
      child: Container(
        width: 100,
        height: 100,
        color: Colors.red,
        child: Center(
          child: Text('Rotating', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 53: Tween في Animation - الأنواع وال使用                          │
// │  Question 53: Tween in Animation - Types and Usage                      │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   الـ Tween هو اختصار لـ "In-Between" - بيبين القيمة في الوقت الحالي.
//
//   أنواع الـ Tween:
//   ● Tween<double>: للأرقام العشرية
//   ● Tween<int>: للأرقام الصحيحة
//   ● Tween<Color?>: للألوان
//   ● Tween<Size>: للأحجام
//   ● Tween<Offset>: للحركات
//   ● Tween<RelativeRect>: للمواقع النسبية
//   ● Tween<BorderRadius?>: للحدود المدورة
//   ● Tween<Alignment>: للمحاذاة
//
//   استخدام Tween.chain() لدمج Curves:
//   Tween<double>(begin: 0, end: 1)
//     .chain(CurveTween(curve: Curves.easeInOut))
//     .animate(controller);
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Tween stands for "In-Between" - defines value at current time.
//
//   Tween Types:
//   ● Tween<double>: For decimal numbers
//   ● Tween<int>: For integers
//   ● Tween<Color?>: For colors
//   ● Tween<Size>: For sizes
//   ● Tween<Offset>: For movements
//   ● Tween<RelativeRect>: For relative positions
//   ● Tween<BorderRadius?>: For rounded borders
//   ● Tween<Alignment>: For alignment
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class TweenDemo extends StatefulWidget {
  const TweenDemo({Key? key}) : super(key: key);

  @override
  _TweenDemoState createState() => _TweenDemoState();
}

class _TweenDemoState extends State<TweenDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<Color?> _colorAnim;
  late Animation<BorderRadius?> _borderAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // ═══ Tween<double> للحجم ═══
    _scaleAnim = Tween<double>(begin: 0.5, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // ═══ ColorTween للون ═══
    _colorAnim = ColorTween(begin: Colors.red, end: Colors.purple).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // ═══ BorderRadiusTween للحدود ═══
    _borderAnim = Tween<BorderRadius?>(
      begin: BorderRadius.circular(0),
      end: BorderRadius.circular(50),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // ═══ OffsetTween للحركة ═══
    _slideAnim = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset(1, 0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tween Demo')),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: _slideAnim.value * 100,
              child: Transform.scale(
                scale: _scaleAnim.value,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: _colorAnim.value,
                    borderRadius: _borderAnim.value,
                  ),
                  child: Center(
                    child: Text('Tween', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 54: Rive و Lottie في Flutter                                     │
// │  Question 54: Rive and Lottie in Flutter                                │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Rive:
//   ● أداة لعمل أنيميشن تفاعلية
//   ● بيستخدم State Machine
//   ● مناسب للـ Interactive animations
//   ● حجم صغير
//
//   Lottie:
//   ● بيستخدم After Effects animations
//   ● سهل في الاستخدام
//   ● مناسب للـ Decorative animations
//   ● حجم أكبر من Rive
//
//   متى نستخدم كل واحد؟
//   ● Rive: لما محتاج تفاعل (زي أزرار، loading states)
//   ● Lottie: لما محتاج أنيميشن جمالية (زي success screens)
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Rive:
//   ● Tool for interactive animations
//   ● Uses State Machine
//   ● Good for Interactive animations
//   ● Small file size
//
//   Lottie:
//   ● Uses After Effects animations
//   ● Easy to use
//   ● Good for Decorative animations
//   ● Larger file size than Rive
//
//   When to use each:
//   ● Rive: When you need interactivity (buttons, loading states)
//   ● Lottie: When you need decorative animations (success screens)
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// ═══ استخدام Lottie ═══
// import 'package:lottie/lottie.dart';
//
// class LottieDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Lottie.asset(
//           'assets/animations/success.json',
//           width: 200,
//           height: 200,
//           repeat: true,
//         ),
//       ),
//     );
//   }
// }

// ═══ استخدام Rive ═══
// import 'package:rive/rive.dart';
//
// class RiveDemo extends StatefulWidget {
//   @override
//   _RiveDemoState createState() => _RiveDemoState();
// }
//
// class _RiveDemoState extends State<RiveDemo> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: RiveAnimation.asset(
//           'assets/animations/character.riv',
//           onInit: (artboard) {
//             // تحكم في الـ Animation
//           },
//         ),
//       ),
//     );
//   }
// }


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 55: Animation Performance Tips                                  │
// │  Question 55: نصائح تحسين أداء الأنيميشن                               │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   1. استخدم Implicit Animations للـ Simple animations
//      - أسرع وأقل استهلاك للموارد
//
//   2. استخدم RepaintBoundary
//      - يمنع إعادة رسم الـ Widget غير المتأثر
//
//   3. تجنب Heavy calculations في الـ Animation
//      - استخدم cached values
//
//   4. استخدم const Widgets قدر الإمكان
//      - بيقلل الـ Rebuilds
//
//   5. حدّد الـ Duration صح
//      - أقصر مدة ممكنة
//
//   6. استخدم Curves بعناية
//      - بعض الـ Curves أثقل من غيرها
//
//   7. dispose() الـ AnimationController
//      - عشان ميقفش الـ Memory
//
//   8. استخدم TickerProviderStateMixin بس لما محتاج أكتر من AnimationController
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   1. Use Implicit Animations for simple animations
//   2. Use RepaintBoundary
//   3. Avoid heavy calculations in animation
//   4. Use const Widgets when possible
//   5. Set appropriate Duration
//   6. Use Curves carefully
//   7. Always dispose AnimationController
//   8. Use TickerProviderStateMixin only when needed
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 56: Implicit vs Explicit Animation - متى نستخدم كل واحد         │
// │  Question 56: Implicit vs Explicit Animation - When to Use Each         │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   استخدم Implicit Animation عندما:
//   ● الـ Animation بسيط (تغيير لون، حجم، موضع)
//   ● محتاج تبدأ بسرعة
//   ● مش محتاج تحكم كامل
//   ● مثال: زر بيتغير لونه لما تضغط عليه
//
//   استخدم Explicit Animation عندما:
//   ● الـ Animation معقد (تسلسل، تكرار، تحكم في التوقيت)
//   ● محتاج تحكم كامل (pause, reverse, repeat)
//   ● محتاج تستخدم AnimationController
//   ● مثال: شاشة loading معقدة
//
//   مثال على التمييز:
//   ● Implicit: زر بيتمدد لما تضغط عليه
//   ● Explicit: character بيتحرك على الشاشة
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Use Implicit Animation when:
//   ● Animation is simple (color, size, position change)
//   ● Need quick start
//   ● Don't need full control
//   ● Example: Button color change on tap
//
//   Use Explicit Animation when:
//   ● Animation is complex (sequencing, timing control)
//   ● Need full control (pause, reverse, repeat)
//   ● Need AnimationController
//   ● Example: Complex loading screen
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 57: Custom Page Transitions في Flutter                           │
// │  Question 57: Custom Page Transitions in Flutter                        │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Flutter بيقدم طرق كتير للـ Custom Page Transitions:
//
//   1. PageRouteBuilder: أسهل طريقة
//   2. CustomTransitionsPackage: مكتبة جاهزة
//   3. Hero Animations: للانتقال بين الشاشات
//
//   أنواع الـ Transitions:
//   ● SlideTransition: الشاشة بتنزلق
//   ● FadeTransition: الشاشة بتتلاشى
//   ● ScaleTransition: الشاشة بتتقلص أو بتتدد
//   ● RotationTransition: الشاشة بتدور
//   ● SizeTransition: الشاشة بتتغير في الحجم
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Flutter provides various Custom Page Transitions:
//
//   1. PageRouteBuilder: Easiest way
//   2. CustomTransitionsPackage: Ready-made library
//   3. Hero Animations: For screen transitions
//
//   Transition Types:
//   ● SlideTransition: Screen slides
//   ● FadeTransition: Screen fades
//   ● ScaleTransition: Screen scales
//   ● RotationTransition: Screen rotates
//   ● SizeTransition: Screen changes size
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// ═══ Slide + Fade Transition ═══
class SlideFadeRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  SlideFadeRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            );

            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0)
                    .animate(curvedAnimation),
                child: child,
              ),
            );
          },
          transitionDuration: Duration(milliseconds: 500),
        );
}

// ═══ Scale Transition ═══
class ScaleRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  ScaleRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return ScaleTransition(
              scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
              ),
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 400),
        );
}

// ═══ Rotation Transition ═══
class RotationRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  RotationRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return RotationTransition(
              turns: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 600),
        );
}


// ██████████████████████████████████████████████████████████████████████████████
//                              PART 11
//              Architecture Patterns - أنماط الاركتيكتشر
// ██████████████████████████████████████████████████████████████████████████████


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 58: MVC - Model View Controller                                 │
// │  Question 58: MVC - Model View Controller                               │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   MVC هو أقدم نمط في تطوير البرمجيات.
//
//   المكونات:
//   ● Model: البيانات والمنطق (Data + Business Logic)
//   ● View: واجهة المستخدم (UI)
//   ● Controller: بيتحكم في التدفق بين الـ Model و الـ View
//
//   المميزات:
//   ● بسيط وسهل في الفهم
//   ● مناسب للمشاريع الصغيرة
//
//   العيوب:
//   ● الـ Controller بيكون كبير وheavy
//   ● صعب في الاختبار
//   ● الـ View والـ Model متصلين ببعض
//
//   في Flutter:
//   ● الـ Widget = View
//   ● الـ State = Model
//   ● الـ setState = Controller
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   MVC is the oldest pattern in software development.
//
//   Components:
//   ● Model: Data + Business Logic
//   ● View: User Interface (UI)
//   ● Controller: Manages flow between Model and View
//
//   Pros: Simple, easy to understand, good for small projects
//   Cons: Controller becomes heavy, hard to test, View and Model coupled
//
//   In Flutter:
//   ● Widget = View
//   ● State = Model
//   ● setState = Controller
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// ═══ Model ═══
class TaskModel {
  String title;
  bool isCompleted;

  TaskModel({required this.title, this.isCompleted = false});

  void toggle() {
    isCompleted = !isCompleted;
  }
}

// ═══ Controller ═══
class TaskController {
  final List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  void addTask(String title) {
    _tasks.add(TaskModel(title: title));
  }

  void toggleTask(int index) {
    _tasks[index].toggle();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
  }
}

// ═══ View ═══
class TaskMVCScreen extends StatefulWidget {
  @override
  _TaskMVCScreenState createState() => _TaskMVCScreenState();
}

class _TaskMVCScreenState extends State<TaskMVCScreen> {
  final TaskController _controller = TaskController();
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MVC Task App')),
      body: ListView.builder(
        itemCount: _controller.tasks.length,
        itemBuilder: (context, index) {
          final task = _controller.tasks[index];
          return ListTile(
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (value) {
                setState(() => _controller.toggleTask(index));
              },
            ),
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() => _controller.deleteTask(index));
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Add Task'),
              content: TextField(controller: _textController),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _controller.addTask(_textController.text);
                      _textController.clear();
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 59: MVVM - Model View ViewModel                                 │
// │  Question 59: MVVM - Model View ViewModel                               │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   MVVM هو تطور على MVC، بيفرقي بين الـ View والـ ViewModel.
//
//   المكونات:
//   ● Model: البيانات والمنطق
//   ● View: واجهة المستخدم
//   ● ViewModel: بيعرض البيانات للـ View وبيتعامل مع الأحداث
//
//   الفرق مع MVC:
//   ● الـ ViewModel مش محتاج يعرف الـ View
//   ● Data Binding بين الـ View والـ ViewModel
//   ● أسهل في الاختبار
//
//   المميزات:
//   ● Data Binding تلقائي
//   ● أسهل في اختبار الـ ViewModel
//   ● مناسب للمشاريع المتوسطة والكبيرة
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   MVVM is an evolution of MVC, separating View from ViewModel.
//
//   Components:
//   ● Model: Data + Business Logic
//   ● View: User Interface
//   ● ViewModel: Exposes data to View and handles events
//
//   Differences from MVC:
//   ● ViewModel doesn't need to know the View
//   ● Data Binding between View and ViewModel
//   ● Easier to test
//
//   Pros: Auto Data Binding, easier ViewModel testing, good for medium/large apps
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// ═══ Model ═══
class UserModel {
  final String name;
  final String email;

  UserModel({required this.name, required this.email});
}

// ═══ ViewModel (بيستخدم ChangeNotifier) ═══
class UserViewModel extends ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadUser(int userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(Duration(seconds: 1));
      _user = UserModel(
        name: 'User $userId',
        email: 'user$userId@example.com',
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateUser(String name, String email) {
    _user = UserModel(name: name, email: email);
    notifyListeners();
  }
}

// ═══ View ═══
class UserMVVMScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserViewModel()..loadUser(1),
      child: Scaffold(
        appBar: AppBar(title: Text('MVVM User App')),
        body: Consumer<UserViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (viewModel.error != null) {
              return Center(child: Text('Error: ${viewModel.error}'));
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Name: ${viewModel.user?.name ?? 'N/A'}',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Email: ${viewModel.user?.email ?? 'N/A'}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 60: Clean Architecture                                          │
// │  Question 60: Clean Architecture                                        │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Clean Architecture هو نمط مقترح من Robert C. Martin (Uncle Bob).
//   بيفصل الـ App لـ 3 طبقات رئيسية:
//
//   ══════════════════════════════════════════════════════════════════════════
//   الطبقة 1: Presentation Layer (طبقة العرض)
//   ══════════════════════════════════════════════════════════════════════════
//   ● Pages/Screens: الشاشات
//   ● Widgets: الويدجتات
//   ● BLoC/Cubit/ViewModel: بيتحكم في الحالة
//
//   ══════════════════════════════════════════════════════════════════════════
//   الطبقة 2: Domain Layer (طبقة النطاق)
//   ══════════════════════════════════════════════════════════════════════════
//   ● Entities: الكائنات الأساسية (بسيطة)
//   ● Use Cases: العمليات البيزنس
//   ● Repository Interfaces: واجهات المستودعات (مفيش تنفيذ)
//
//   ══════════════════════════════════════════════════════════════════════════
//   الطبقة 3: Data Layer (طبقة البيانات)
//   ══════════════════════════════════════════════════════════════════════════
//   ● Models: النماذج ( فيها conversions)
//   ● Data Sources: مصادر البيانات (API, Database)
//   ● Repository Implementations: تنفيذ الـ Repository
//
//   ══════════════════════════════════════════════════════════════════════════
//   قاعدة Dependency Rule:
//   ══════════════════════════════════════════════════════════════════════════
//   الـ Dependency لازم يروح من برّا لجوّا:
//   Presentation → Domain ← Data
//
//   يعني:
//   ● الـ Domain مش عارف الـ Data ولا الـ Presentation
//   ● الـ Data بتعتمد على الـ Domain
//   ● الـ Presentation بتعتمد على الـ Domain
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Clean Architecture is a pattern by Robert C. Martin (Uncle Bob).
//   Divides app into 3 main layers:
//
//   Layer 1: Presentation Layer
//   ● Pages/Screens, Widgets, BLoC/Cubit/ViewModel
//
//   Layer 2: Domain Layer
//   ● Entities, Use Cases, Repository Interfaces (no implementation)
//
//   Layer 3: Data Layer
//   ● Models (with conversions), Data Sources, Repository Implementations
//
//   Dependency Rule:
//   Dependencies go from outside to inside:
//   Presentation → Domain ← Data
//
//   Meaning:
//   ● Domain doesn't know Data or Presentation
//   ● Data depends on Domain
//   ● Presentation depends on Domain
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// ══════════════════════════════════════════════════════════════════════════
//   Domain Layer
// ══════════════════════════════════════════════════════════════════════════

// Entity (بسيط، مفيش dependencies)
class NoteEntity {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;

  NoteEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });
}

// Use Case (بيستخدم Entity بس)
abstract class GetNotesUseCase {
  Future<List<NoteEntity>> call();
}

abstract class AddNoteUseCase {
  Future<void> call(NoteEntity note);
}

// Repository Interface (مفيش تنفيذ)
abstract class NoteRepository {
  Future<List<NoteEntity>> getNotes();
  Future<void> addNote(NoteEntity note);
  Future<void> deleteNote(String id);
}

// ══════════════════════════════════════════════════════════════════════════
//   Data Layer
// ══════════════════════════════════════════════════════════════════════════

// Model (فيها conversions)
class NoteModel extends NoteEntity {
  NoteModel({
    required String id,
    required String title,
    required String content,
    required DateTime createdAt,
  }) : super(id: id, title: title, content: content, createdAt: createdAt);

  // من JSON لـ Model
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // من Model لـ JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // من Model لـ Entity
  NoteEntity toEntity() {
    return NoteEntity(
      id: id,
      title: title,
      content: content,
      createdAt: createdAt,
    );
  }
}

// Data Source (مصدر البيانات)
abstract class NoteLocalDataSource {
  Future<List<NoteModel>> getNotes();
  Future<void> saveNote(NoteModel note);
  Future<void> deleteNote(String id);
}

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  final List<NoteModel> _notes = [];

  @override
  Future<List<NoteModel>> getNotes() async {
    return _notes;
  }

  @override
  Future<void> saveNote(NoteModel note) async {
    _notes.add(note);
  }

  @override
  Future<void> deleteNote(String id) async {
    _notes.removeWhere((note) => note.id == id);
  }
}

// Repository Implementation
class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource _localDataSource;

  NoteRepositoryImpl(this._localDataSource);

  @override
  Future<List<NoteEntity>> getNotes() async {
    final models = await _localDataSource.getNotes();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addNote(NoteEntity note) async {
    final model = NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      createdAt: note.createdAt,
    );
    await _localDataSource.saveNote(model);
  }

  @override
  Future<void> deleteNote(String id) async {
    await _localDataSource.deleteNote(id);
  }
}

// ══════════════════════════════════════════════════════════════════════════
//   Presentation Layer
// ══════════════════════════════════════════════════════════════════════════

// Cubit/BLoC
class NotesCubit extends Cubit<List<NoteEntity>> {
  final GetNotesUseCase _getNotes;
  final AddNoteUseCase _addNote;

  NotesCubit(this._getNotes, this._addNote) : super([]);

  Future<void> loadNotes() async {
    final notes = await _getNotes();
    emit(notes);
  }

  Future<void> addNote(String title, String content) async {
    final note = NoteEntity(
      id: DateTime.now().toString(),
      title: title,
      content: content,
      createdAt: DateTime.now(),
    );
    await _addNote(note);
    await loadNotes();
  }
}

// Screen
class NotesCleanArchitectureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final repository = NoteRepositoryImpl(NoteLocalDataSourceImpl());
        return NotesCubit(
          GetNotesUseCaseImpl(repository),
          AddNoteUseCaseImpl(repository),
        )..loadNotes();
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Clean Architecture Notes')),
        body: BlocBuilder<NotesCubit, List<NoteEntity>>(
          builder: (context, notes) {
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                );
              },
            );
          },
        ),
      ),
    );
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 61: BLoC Architecture                                           │
// │  Question 61: BLoC Architecture                                         │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   BLoC (Business Logic Component) نمط بيفرقي بين الـ UI والـ Logic.
//
//   المكونات:
//   ● Events: الأحداث اللي بتحصل (زي الأزرار)
//   ● States: الحالات المختلفة للـ UI
//   ● BLoC: بيتحول بين الـ States بناءً على الـ Events
//
//   المميزات:
//   ● منظم وواضح
//   ● سهل في الاختبار
//   ● بيستخدم Streams (reactive)
//   ● مناسب للمشاريع الكبيرة
//
//   العيوب:
//   ● Boilerplate كتير
//   ● صعب في البداية
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   BLoC (Business Logic Component) separates UI from Logic.
//
//   Components:
//   ● Events: What happens (button presses)
//   ● States: Different UI states
//   ● BLoC: Transitions between States based on Events
//
//   Pros: Organized, easy to test, uses Streams, good for large apps
//   Cons: Lots of boilerplate, hard at first
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// ═══ Events ═══
abstract class CounterBlocEvent {}
class CounterIncrement extends CounterBlocEvent {}
class CounterDecrement extends CounterBlocEvent {}
class CounterReset extends CounterBlocEvent {}

// ═══ States ═══
class CounterBlocState {
  final int count;
  final bool isLoading;

  CounterBlocState({required this.count, this.isLoading = false});

  CounterBlocState copyWith({int? count, bool? isLoading}) {
    return CounterBlocState(
      count: count ?? this.count,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// ═══ BLoC ═══
class CounterBloc extends Bloc<CounterBlocEvent, CounterBlocState> {
  CounterBloc() : super(CounterBlocState(count: 0)) {
    on<CounterIncrement>((event, emit) {
      emit(state.copyWith(count: state.count + 1));
    });

    on<CounterDecrement>((event, emit) {
      emit(state.copyWith(count: state.count - 1));
    });

    on<CounterReset>((event, emit) {
      emit(CounterBlocState(count: 0));
    });
  }
}

// ═══ Screen ═══
class CounterBlocScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: Scaffold(
        appBar: AppBar(title: Text('BLoC Counter')),
        body: Center(
          child: BlocBuilder<CounterBloc, CounterBlocState>(
            builder: (context, state) {
              return Text(
                'Count: ${state.count}',
                style: TextStyle(fontSize: 48),
              );
            },
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'increment',
              onPressed: () {
                context.read<CounterBloc>().add(CounterIncrement());
              },
              child: Icon(Icons.add),
            ),
            SizedBox(height: 8),
            FloatingActionButton(
              heroTag: 'decrement',
              onPressed: () {
                context.read<CounterBloc>().add(CounterDecrement());
              },
              child: Icon(Icons.remove),
            ),
            SizedBox(height: 8),
            FloatingActionButton(
              heroTag: 'reset',
              onPressed: () {
                context.read<CounterBloc>().add(CounterReset());
              },
              child: Icon(Icons.refresh),
            ),
          ],
        ),
      ),
    );
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 62: Feature-First vs Layer-First Architecture                    │
// │  Question 62: Feature-First vs Layer-First Architecture                 │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Feature-First (بالميزة):
//   lib/
//   ├── features/
//   │   ├── auth/
//   │   │   ├── data/
//   │   │   ├── domain/
//   │   │   └── presentation/
//   │   └── notes/
//   │       ├── data/
//   │       ├── domain/
//   │       └── presentation/
//
//   ● كل ميزة في مجلد منفصل
//   ● كل مجلد فيه Data, Domain, Presentation
//   ● أسهل في الـ Scalability
//
//   Layer-First (بالطبقة):
//   lib/
//   ├── data/
//   │   ├── auth/
//   │   └── notes/
//   ├── domain/
//   │   ├── auth/
//   │   └── notes/
//   └── presentation/
//       ├── auth/
//       └── notes/
//
//   ● كل طبقة في مجلد منفصل
//   ● كل مجلد فيه كل الميزات
//   ● أسهل في الـ Code Sharing
//
//   متى نستخدم كل واحد؟
//   ● Feature-First: للمشاريع الكبيرة مع ميزات كتير
//   ● Layer-First: للمشاريع الصغيرة والمتوسطة
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Feature-First:
//   Each feature in separate folder with data, domain, presentation
//   Easier for Scalability
//
//   Layer-First:
//   Each layer in separate folder with all features
//   Easier for Code Sharing
//
//   When to use:
//   ● Feature-First: Large projects with many features
//   ● Layer-First: Small to medium projects
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 63: Provider Architecture في Flutter                             │
// │  Question 63: Provider Architecture in Flutter                          │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Provider أكتر نمط شعبية في Flutter.
//
//   المكونات:
//   ● ChangeNotifier: الـ Model اللي بيتغير
//   ● ChangeNotifierProvider: بيوفّر الـ ChangeNotifier
//   ● Consumer: بيستهلك الـ Data
//   ● Selector: بيختار جزء معين من الـ Data
//
//   المميزات:
//   ● سهل وسريع في الاستخدام
//   ● مناسب للمشاريع الصغيرة والمتوسطة
//   ● بيستخدم InheritedWidget من تحت
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Provider is the most popular pattern in Flutter.
//
//   Components:
//   ● ChangeNotifier: Mutable model
//   ● ChangeNotifierProvider: Provides ChangeNotifier
//   ● Consumer: Consumes data
//   ● Selector: Selects specific data portion
//
//   Pros: Easy and fast, good for small/medium apps, uses InheritedWidget
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// ═══ ChangeNotifier ═══
class CartModel extends ChangeNotifier {
  final List<String> _items = [];

  List<String> get items => _items;
  int get itemCount => _items.length;

  void addItem(String item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(String item) {
    _items.remove(item);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

// ═══ Screen مع Provider ═══
class CartProviderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartModel(),
      child: Scaffold(
        appBar: AppBar(title: Text('Provider Cart')),
        body: Consumer<CartModel>(
          builder: (context, cart, child) {
            return ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(cart.items[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      cart.removeItem(cart.items[index]);
                    },
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<CartModel>().addItem('Item ${DateTime.now().second}');
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 64: GetX Architecture                                           │
// │  Question 64: GetX Architecture                                         │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   GetX مكتبة شاملة بتنحل كل المشاكل في Flutter.
//
//   المكونات:
//   ● GetxController: الـ Controller
//   ● Obx: الـ Widget اللي بيتغير
//   ● GetMaterialApp: الـ App
//   ● Get.to(): التنقل
//   ● Get.find(): Dependency Injection
//
//   المميزات:
//   ● سهل وسريع
//   ● boilerplate قليل
//   ● بيجمع كل حاجة في مكتبة واحدة
//
//   العيوب:
//   ● ممكن يخلي الكود أقل وضوحاً
//   ● صعب في refactor
//   ● ممكن يسبب coupling
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   GetX is an all-in-one solution for Flutter.
//
//   Components:
//   ● GetxController: The controller
//   ● Obx: Widget that changes
//   ● GetMaterialApp: The app
//   ● Get.to(): Navigation
//   ● Get.find(): Dependency Injection
//
//   Pros: Easy and fast, less boilerplate, all-in-one
//   Cons: Less readable, hard to refactor, can cause coupling
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// ═══ Controller ═══
class CounterGetxController extends GetxController {
  var count = 0.obs;

  void increment() => count++;
  void decrement() => count--;
  void reset() => count.value = 0;
}

// ═══ Screen ═══
class CounterGetxScreen extends StatelessWidget {
  final controller = Get.put(CounterGetxController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GetX Counter')),
      body: Center(
        child: Obx(() => Text(
          'Count: ${controller.count}',
          style: TextStyle(fontSize: 48),
        )),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'increment',
            onPressed: controller.increment,
            child: Icon(Icons.add),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'decrement',
            onPressed: controller.decrement,
            child: Icon(Icons.remove),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'reset',
            onPressed: controller.reset,
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 65: مقارنة بين الـ Architectures المختلفة                        │
// │  Question 65: Comparison between Different Architectures                │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   ┌─────────────┬─────────────────┬─────────────────┬───────────────────┐
//   │  النمط      │  مناسب لـ       │  السهولة        │  الاختبار         │
//   ├─────────────┼─────────────────┼─────────────────┼───────────────────┤
//   │  MVC        │  مشاريع صغيرة   │  سهل جداً       │  صعب             │
//   │  MVVM       │  مشاريع متوسطة  │  سهل           │  متوسط           │
//   │  BLoC       │  مشاريع كبيرة   │  متوسط         │  سهل جداً        │
//   │  Provider   │  مشاريع صغيرة   │  سهل جداً       │  متوسط           │
//   │  GetX       │  مشاريع صغيرة   │  سهل جداً       │  صعب             │
//   │  Clean Arch │  مشاريع كبيرة   │  صعب           │  سهل جداً        │
//   └─────────────┴─────────────────┴─────────────────┴───────────────────┘
//
//   نصيحة للإنترفيو:
//   ● ابدأ بالـ Provider لو مشروع صغير
//   ● استخدم BLoC/Clean Architecture للمشاريع الكبيرة
//   ● اعرف كل واحد ومتى تستخدمه
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   ┌─────────────┬─────────────────┬─────────────────┬───────────────────┐
//   │  Pattern    │  Best For       │  Ease           │  Testing         │
//   ├─────────────┼─────────────────┼─────────────────┼───────────────────┤
//   │  MVC        │  Small projects │  Very easy      │  Hard            │
//   │  MVVM       │  Medium projects│  Easy           │  Medium          │
//   │  BLoC       │  Large projects │  Medium         │  Very easy       │
//   │  Provider   │  Small projects │  Very easy      │  Medium          │
//   │  GetX       │  Small projects │  Very easy      │  Hard            │
//   │  Clean Arch │  Large projects │  Hard           │  Very easy       │
//   └─────────────┴─────────────────┴─────────────────┴───────────────────┘
//
//   Interview Tip:
//   ● Start with Provider for small projects
//   ● Use BLoC/Clean Architecture for large projects
//   ● Know each one and when to use it
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


// ┌──────────────────────────────────────────────────────────────────────────┐
// │  السؤال 66: Dependency Injection في Flutter                              │
// │  Question 66: Dependency Injection in Flutter                           │
// └──────────────────────────────────────────────────────────────────────────┘
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           الإجابة بالعربي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Dependency Injection (DI) طريقة لحقن الـ Dependencies بدل ما تنشئها يدوياً.
//
//   ليه نستخدمه؟
//   1. تقليل الـ Coupling
//   2. سهولة الاختبار (ممكن تستخدم Mocks)
//   3. إعادة استخدام الكود
//
//   طرق الـ DI في Flutter:
//   1. Constructor Injection: الأسهل
//   2. Provider: الشائعة
//   3. GetX: السريعة
//   4. get_it: القوية
//   5. injectable: التلقائية
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                           English Answer
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//
//   Dependency Injection (DI) is a way to inject dependencies instead of
//   creating them manually.
//
//   Why use it?
//   1. Reduce Coupling
//   2. Easy testing (can use Mocks)
//   3. Code reuse
//
//   DI Methods in Flutter:
//   1. Constructor Injection: Easiest
//   2. Provider: Most popular
//   3. GetX: Fastest
//   4. get_it: Most powerful
//   5. injectable: Automatic
//
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//                               مثال عملي
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// ═══ Constructor Injection ═══
class ApiService {
  Future<List<String>> fetchUsers() async {
    return ['Ahmed', 'Sara', 'Mohamed'];
  }
}

class UserRepository {
  final ApiService _apiService;

  // ═══ Dependency Injection عبر Constructor ═══
  UserRepository(this._apiService);

  Future<List<String>> getUsers() async {
    return await _apiService.fetchUsers();
  }
}

class UserListViewModel extends ChangeNotifier {
  final UserRepository _repository;

  // ═══ Dependency Injection عبر Constructor ═══
  UserListViewModel(this._repository);

  List<String> _users = [];
  List<String> get users => _users;

  Future<void> loadUsers() async {
    _users = await _repository.getUsers();
    notifyListeners();
  }
}

// ═══ استخدام مع Provider ═══
class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiService>(create: (_) => ApiService()),
        Provider<UserRepository>(
          create: (context) => UserRepository(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => UserListViewModel(context.read<UserRepository>()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text('DI with Provider')),
        body: Consumer<UserListViewModel>(
          builder: (context, viewModel, child) {
            return ListView.builder(
              itemCount: viewModel.users.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(viewModel.users[index]));
              },
            );
          },
        ),
      ),
    );
  }
}


// ██████████████████████████████████████████████████████████████████████████████
//                           Quick Reference
//                        ملخص سريع للمراجعة
// ██████████████████████████████████████████████████████████████████████████████
//
//   Dart Keywords:
//   - var, final, const, dynamic
//   - async, await, yield
//   - extends, implements, with
//   - abstract, interface
//
//   Flutter Widgets:
//   - StatelessWidget, StatefulWidget
//   - Container, Row, Column
//   - ListView, GridView
//   - Stack, Positioned
//
//   State Management:
//   - setState()
//   - Provider
//   - Riverpod
//   - Bloc/Cubit
//   - GetX
//
//   SOLID Principles:
//   - SRP: Single Responsibility
//   - OCP: Open/Closed
//   - LSP: Liskov Substitution
//   - ISP: Interface Segregation
//   - DIP: Dependency Inversion
//
//   Animation:
//   - Implicit: AnimatedContainer, AnimatedOpacity, AnimatedSwitcher
//   - Explicit: AnimationController, Tween, CurvedAnimation
//   - Hero: For screen transitions
//   - Staggered: Sequential animations
//   - Curves: easeIn, easeOut, bounceOut, elasticOut
//   - Rive/Lottie: External animation tools
//
//   Architecture:
//   - MVC: Model-View-Controller (Small apps)
//   - MVVM: Model-View-ViewModel (Medium apps)
//   - BLoC: Business Logic Component (Large apps)
//   - Clean Architecture: 3 Layers (Enterprise apps)
//   - Provider: Simple state management
//   - GetX: All-in-one solution
//
//   Testing:
//   - Unit Tests
//   - Widget Tests
//   - Integration Tests
//
//   Performance:
//   - const Widgets
//   - ListView.builder
//   - Code Splitting
//   - RepaintBoundary
//
// ██████████████████████████████████████████████████████████████████████████████
//                         End of Interview Preparation
// ██████████████████████████████████████████████████████████████████████████████
