class mainuser{
  String name;
  String username;
  String password;
  String ? imageUrl;
  String ?type;

  mainuser({
    required this.name,
    required this.username,
    required this.password,
    this.imageUrl,
    this.type,
  });


  void login(){}
  void signup(){}
}