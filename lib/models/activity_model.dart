class ActivityModel {
  String placeName;
  String menu;
  String orderDate;
  String orderTime; 
  int total;

  ActivityModel({
    required this.placeName , 
    required this.menu , 
    required this.orderTime , 
    required this.total , 
    required this.orderDate,
  });
}