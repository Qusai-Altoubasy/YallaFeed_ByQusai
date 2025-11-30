class donation {
  String mealType;
  int numberOfPeople;
  String ?category;
  String fromlocation;
  String ?tolocation;
  String ?description;
  String imagePath;
  String status;

  donation({
    required this.mealType,
    required this.numberOfPeople,
    this.category,
    required this.fromlocation,
    this.tolocation,
    this.description,
    required this.imagePath,
    required this.status,
  });


}