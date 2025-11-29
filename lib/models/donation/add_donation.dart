class AddDonationModel {
  final String mealType;
  final int numberOfPeople;
  String? category;
  final String location;
  String? description;
  final String imagePath;

  AddDonationModel({
    required this.mealType,
    required this.numberOfPeople,
    this.category,
    required this.location,
    this.description,
    required this.imagePath,
  });

  factory AddDonationModel.fromJson(Map<String, dynamic> json) {
    return AddDonationModel(
      mealType: json['mealType'],
      numberOfPeople: json['numberOfPeople'],
      category: json['category'],
      location: json['location'],
      description: json['description'],
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mealType': mealType,
      'numberOfPeople': numberOfPeople,
      'category': category,
      'location': location,
      'description': description,
      'imagePath': imagePath,
    };
  }
}