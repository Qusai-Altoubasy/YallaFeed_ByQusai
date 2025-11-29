class AnnouncementModel {
  final String title;
  final String message;
  final String sendTo;

  AnnouncementModel({
    required this.title,
    required this.message,
    required this.sendTo,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      title: json['title'],
      message: json['message'],
      sendTo: json['sendTo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
      'sendTo': sendTo,
    };
  }
}