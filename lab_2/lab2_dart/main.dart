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

void exercise1() {
  int age = 22;
  double gpa = 2.956;
  String name = "Bao";
  bool isStudent = true;
  print("Tên: $name");
  print("Tuổi: $age");
  print("GPA: $gpa");
  print("Là sinh viên: $isStudent");
}

void exercise2() {
  List<int> numbers = [10, 20, 30];
  print("Danh sách số: $numbers");
  int sum = numbers[0] + numbers[1];
  bool isEqual = (numbers[0] == 10);
  bool checkBoth = (numbers[0] < 20) && (numbers[1] > 15);
  String result = (sum > 25) ? "Lớn hơn 25" : "Nhỏ hơn hoặc bằng 25";

  print("Tổng của hai số đầu tiên: $sum");
  print("So sánh bằng: $isEqual");
  print("Cả 2 điều kiện đúng: $checkBoth");
  print("Kết quả ternary: $result");

  Set<String> fruits = {"apple", "banana"};
  fruits.add("cherry");
  fruits.add("apple");
  print("Set fruits: $fruits");

  Map<String, int> studentScores = {"Alice": 90, "Bob": 85};
  studentScores["Charlie"] = 95;

  numbers.add(50);
  numbers.remove(10);

  print("List numbers sau khi thêm và xóa: $numbers");
  print("Map studentScores: $studentScores");
  print("Bob's score: ${studentScores["Bob"]}");
}

void exercise3() {
  int score = 75;
  if (score >= 90)
    print("Điểm A");
  else if (score >= 80)
    print("Điểm B");
  else if (score >= 70)
    print("Điểm C");
  else if (score >= 60)
    print("Điểm D");
  else
    print("Điểm F");

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
    case 4:
      print("Thứ Năm");
      break;
    case 5:
      print("Thứ Sáu");
      break;
    case 6:
      print("Thứ Bảy");
      break;
    case 7:
      print("Chủ Nhật");
      break;
    default:
      print("Ngày không hợp lệ");
  }

  List<int> nums = [1, 2, 3, 4, 5];

  for (int i = 0; i < nums.length; i++) {
    print("for loop: ${nums[i]}");
  }

  for (var n in nums) {
    print("for-in loop: $n");
  }

  nums.forEach((n) => print("forEach loop: $n"));

  int square(int x) {
    return x * x;
  }

  int cube(int x) => x * x * x;

  print("Square of 3: ${square(3)}");
  print("Cube of 3: ${cube(3)}");
}

class Car {
    String brand;
    Car(this.brand);
    Car.unknownBrand() : brand = "Unknown";

    void drive() {
        print("$brand is driving");
    }
}

class ElectricCar extends Car {
    ElectricCar(String brand) : super(brand);

    @override
    void drive() {
        print("$brand is driving silently");
    }
}

void exercise4() {
    Car myCar = Car("Toyota");
    myCar.drive();

    Car mysteryCar = Car.unknownBrand();
    mysteryCar.drive();

    ElectricCar myElectricCar = ElectricCar("Tesla");
    myElectricCar.drive();
}


Future<String> fetchUserName() async {
    await Future.delayed(Duration(seconds: 2));
    return "Bao";
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

  nickname = "Tendou Arisu";
  print("Độ dài biệt danh: ${nickname!.length}");

  print("Bắt đầu tải dữ liệu người dùng...");
  String name = await fetchUserName();
  print("Đã tải xong, tên người dùng: $name");

  print("Bắt đầu đếm qua Stream:");
  await for (var value in countStream()) {
    print("Giá trị từ Stream: $value");
  }
}