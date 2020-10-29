class Order {
  static int _counter = 0;
  int id;
  String deliveryMan;
  double price;
  DateTime orderDate;

  Order({this.deliveryMan, this.price, this.orderDate}) {
    id = _counter;
    _counter++;
  }
}
