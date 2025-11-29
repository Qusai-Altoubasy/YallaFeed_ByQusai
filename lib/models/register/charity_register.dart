class CharityRegisterModel {
  final String organizationName;
  final String email;
  final String phone;
  final String governmentalId;
  final String password;

  CharityRegisterModel({
    required this.organizationName,
    required this.email,
    required this.phone,
    required this.governmentalId,
    required this.password,
  });

  factory CharityRegisterModel.fromJson(Map<String, dynamic> json) {
    return CharityRegisterModel(
      organizationName: json['organizationName'],
      email: json['email'],
      phone: json['phone'],
      governmentalId: json['governmentalId'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'organizationName': organizationName,
      'email': email,
      'phone': phone,
      'governmentalId': governmentalId,
      'password': password,
    };
  }
}