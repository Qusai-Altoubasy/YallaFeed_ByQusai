class donation {
  String mealType;
  int numberOfPeople;
  String ?category;
  String fromlocation;
  String ?tolocation;
  String ?description;
  String imagePath;
  String status;
  String donoruid;
  String reciveruid;
  String deleiveruid;

  donation({
    required this.mealType,
    required this.numberOfPeople,
    this.category,
    required this.fromlocation,
    this.tolocation,
    this.description,
    required this.imagePath,
    required this.status,
    required this.deleiveruid,
    required this.donoruid,
    required this.reciveruid,
  });


}