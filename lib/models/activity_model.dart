class ActivityModel {
  String placeName;
  String? image;
  String menu;
  String orderDate;
  String orderTime; 
  int total;

  ActivityModel({
    required this.placeName , 
     this.image,
    required this.menu , 
    required this.orderTime , 
    required this.total , 
    required this.orderDate,
  });
}