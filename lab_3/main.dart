import 'dart:async';
import 'dart:convert';

void main() async {
  print("===== Exercise 1 =====");
  await exercise1();

  print("\n===== Exercise 2 =====");
  await exercise2();

  print("\n===== Exercise 3 =====");
  exercise3();
  await Future.delayed(Duration(milliseconds: 500)); 

  print("\n===== Exercise 4 =====");
  await exercise4();

  print("\n===== Exercise 5 =====");
  exercise5();
}

// ---------- Exercise 1 ----------
class Product {
  int id;
  String name;
  double price;

  Product(this.id, this.name, this.price);

  @override
  String toString() => "Product(id: $id, name: $name, price: $price)";
}

class ProductRepository {
  final List<Product> _products = [
    Product(1, "Bàn phím", 250000),
    Product(2, "Chuột", 150000),
  ];

  final StreamController<Product> _controller = StreamController<Product>.broadcast();

  Future<List<Product>> getAll() async {
    await Future.delayed(Duration(milliseconds: 300));
    return _products;
  }

  Stream<Product> liveAdded() => _controller.stream;

  void addProduct(Product product) {
    _products.add(product);
    _controller.add(product);
  }

  void dispose() => _controller.close();
}

Future<void> exercise1() async {
  final repo = ProductRepository();

  final subscription = repo.liveAdded().listen((product) {
    print("Sản phẩm mới vừa được thêm: $product");
  });

  List<Product> products = await repo.getAll();
  print("Danh sách sản phẩm ban đầu:");
  for (var p in products) {
    print(p);
  }

  repo.addProduct(Product(3, "Tai nghe", 350000));

  await Future.delayed(Duration(milliseconds: 100));
  await subscription.cancel();
  repo.dispose();
}

// ---------- Exercise 2 ----------
class User {
  String name;
  String email;

  User(this.name, this.email);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['name'], json['email']);
  }

  @override
  String toString() => "User(name: $name, email: $email)";
}

class UserRepository {
  Future<List<User>> fetchUsers() async {
    await Future.delayed(Duration(milliseconds: 300));

    String jsonString = '''
    [
      {"name": "An", "email": "an@example.com"},
      {"name": "Binh", "email": "binh@example.com"}
    ]
    ''';

    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((item) => User.fromJson(item)).toList();
  }
}

Future<void> exercise2() async {
  final repo = UserRepository();
  List<User> users = await repo.fetchUsers();

  print("Danh sách user lấy từ JSON:");
  for (var u in users) {
    print(u);
  }
}

// ---------- Exercise 3 ----------
void exercise3() {
  print("1. Code đồng bộ (sync) - chạy đầu tiên");

  Future(() {
    print("3. Future(() {...}) - chạy sau cùng (event queue)");
  });

  scheduleMicrotask(() {
    print("2. scheduleMicrotask - chạy trước Future (microtask queue)");
  });

  print("1b. Code đồng bộ tiếp theo - vẫn chạy trước cả 2 cái trên");
}

// ---------- Exercise 4 ----------
Stream<int> numberStream() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(milliseconds: 100));
    yield i;
  }
}

Future<void> exercise4() async {
  Stream<int> transformed = numberStream()
      .map((n) => n * n)
      .where((n) => n % 2 == 0);

  await for (var value in transformed) {
    print("Giá trị sau map + where: $value");
  }
}

// ---------- Exercise 5 ----------
class Settings {
  Settings._internal();

  static final Settings _instance = Settings._internal();

  factory Settings() {
    return _instance;
  }
}

void exercise5() {
  Settings a = Settings();
  Settings b = Settings();

  print("a và b có phải cùng 1 object không? ${identical(a, b)}");
}