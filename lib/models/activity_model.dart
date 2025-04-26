class ActivityModel {
  String placeName;
  String? image;
  String menu;
  String orderDate;
  String orderTime;
  int total;
  int qty;
  int price;

  ActivityModel({
    required this.placeName,
    this.image,
    required this.qty,
    required this.price,
    required this.menu,
    required this.orderTime,
    required this.total,
    required this.orderDate,
  });
}
