class CardModel {
  int id;
  String? image;
  String title; 
  String description;

  CardModel({
    required this.id , 
    this.image , 
    required this.title , 
    required this.description,
  });

}