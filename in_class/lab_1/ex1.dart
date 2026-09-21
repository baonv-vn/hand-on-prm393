
// TODO 1: Định nghĩa class Vehicle với các thuộc tính String brand, int year.
// Viết Default constructor và hàm void startEngine().
class Vehicle {
  String brand;
  int year;

  Vehicle(this.brand, this.year);

  void startEngine() {
    print("Khởi động phương tiện...");
  }
}
// TODO 2: Định nghĩa class Car kế thừa từ Vehicle.
// Thêm thuộc tính bool isElectric.

class Car extends Vehicle {
  bool isElectric;
  // TODO 3: Viết constructor mặc định cho Car (dùng super để truyền brand và year).
  // Viết Named Constructor: Car.tesla(int year) thiết lập sẵn brand="Tesla" và isElectric=true.
  Car(String brand, int year, this.isElectric) : super(brand, year);
  Car.tesla(int year) : isElectric = true, super("Tesla", year);
  // TODO 4: Ghi đè (@override) hàm startEngine() để in ra thông báo chi tiết hơn.
  @override
  void startEngine() {
    if (isElectric) {
      print("$brand (xe điện) đang khởi động êm không tiếng ồn.");
    } else {
      print("$brand đang khởi động bằng động cơ đốt trong.");
    }
  }
}

void main() {
  // TODO 5: Khởi tạo một xe Car bình thường và gọi startEngine()
  Car myCar = Car("Toyota", 2020, false);
  myCar.startEngine();
  // TODO 6: Khởi tạo một xe Car bằng Named Constructor (Car.tesla) và gọi startEngine()
  Car teslaCar = Car.tesla(2021);
  teslaCar.startEngine();
}
