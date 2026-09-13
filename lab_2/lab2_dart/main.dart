void main() async {
  print("===== Exercise 1 =====");
  exercise1();

  print("\n===== Exercise 2 =====");
  exercise2();

  print("\n===== Exercise 3 =====");
  exercise3();

  print("\n===== Exercise 4 =====");
  exercise4();

  print("\n===== Exercise 5 =====");
  await exercise5();
}

// ---------- Exercise 1 ----------
void exercise1() {
  int age = 20;
  double gpa = 3.75;
  String name = "An";
  bool isStudent = true;

  print("Tên: $name");
  print("Tuổi: $age");
  print("GPA: $gpa");
  print("Là sinh viên: $isStudent");

  print("Năm sau bạn sẽ ${age + 1} tuổi");
  print("GPA làm tròn: ${gpa.round()}");
}

// ---------- Exercise 2 ----------
void exercise2() {
  List<int> numbers = [10, 20, 30, 40];
  print("List ban đầu: $numbers");

  int sum = numbers[0] + numbers[1];
  bool isEqual = (numbers[0] == 10);
  bool checkBoth = (numbers[0] < 20) && (numbers[1] > 10);
  String result = (sum > 25) ? "Lớn hơn 25" : "Nhỏ hơn hoặc bằng 25";

  print("Tổng 2 phần tử đầu: $sum");
  print("So sánh bằng: $isEqual");
  print("Cả 2 điều kiện đúng: $checkBoth");
  print("Kết quả ternary: $result");

  Set<String> fruits = {"apple", "banana"};
  fruits.add("cherry");
  fruits.add("apple");
  print("Set fruits: $fruits");

  Map<String, int> studentScores = {"An": 8, "Binh": 9};
  studentScores["Chi"] = 7;

  numbers.add(50);
  numbers.remove(10);

  print("List sau khi add/remove: $numbers");
  print("Map studentScores: $studentScores");
  print("Điểm của Binh (map access): ${studentScores["Binh"]}");
}

// ---------- Exercise 3 ----------
void exercise3() {
  int score = 75;
  if (score >= 90) {
    print("Xếp loại: Giỏi");
  } else if (score >= 70) {
    print("Xếp loại: Khá");
  } else {
    print("Xếp loại: Cần cố gắng");
  }

  int day = 3;
  switch (day) {
    case 1:
      print("Thứ Hai");
      break;
    case 2:
      print("Thứ Ba");
      break;
    case 3:
      print("Thứ Tư");
      break;
    default:
      print("Ngày khác");
  }

  List<int> nums = [1, 2, 3, 4];

  for (int i = 0; i < nums.length; i++) {
    print("for loop: ${nums[i]}");
  }

  for (var n in nums) {
    print("for-in loop: $n");
  }

  nums.forEach((n) {
    print("forEach loop: $n");
  });

  int square(int x) {
    return x * x;
  }

  int cube(int x) => x * x * x;

  print("Bình phương của 4: ${square(4)}");
  print("Lập phương của 3: ${cube(3)}");
}

// ---------- Exercise 4 ----------
class Car {
  String brand;

  Car(this.brand);

  Car.unknownBrand() : brand = "Unknown";

  void drive() {
    print("$brand đang chạy trên đường.");
  }
}

class ElectricCar extends Car {
  ElectricCar(String brand) : super(brand);

  @override
  void drive() {
    print("$brand (xe điện) đang chạy êm không tiếng ồn.");
  }
}

void exercise4() {
  Car myCar = Car("Toyota");
  myCar.drive();

  Car mysteryCar = Car.unknownBrand();
  mysteryCar.drive();

  ElectricCar myTesla = ElectricCar("Tesla");
  myTesla.drive();
}

// ---------- Exercise 5 ----------
Future<String> fetchUserName() async {
  await Future.delayed(Duration(seconds: 2));
  return "An";
}

Stream<int> countStream() async* {
  for (int i = 1; i <= 3; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

Future<void> exercise5() async {
  String? nickname;
  print("Biệt danh: ${nickname ?? "Chưa đặt biệt danh"}");

  nickname = "Andy";
  print("Độ dài biệt danh: ${nickname!.length}");

  print("Bắt đầu tải dữ liệu người dùng...");
  String name = await fetchUserName();
  print("Đã tải xong, tên người dùng: $name");

  print("Bắt đầu đếm qua Stream:");
  await for (var value in countStream()) {
    print("Giá trị từ Stream: $value");
  }
}