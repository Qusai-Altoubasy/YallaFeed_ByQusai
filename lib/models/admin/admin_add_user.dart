class AdminAddUserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String nationalId;
  final String password;

  AdminAddUserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.nationalId,
    required this.password,
  });

  factory AdminAddUserModel.fromJson(Map<String, dynamic> json) {
    return AdminAddUserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      nationalId: json['nationalId'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'nationalId': nationalId,
      'password': password,
    };
  }
}