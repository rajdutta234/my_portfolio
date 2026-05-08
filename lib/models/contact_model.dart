class ContactModel {
  final int? id;
  final String name;
  final String email;
  final String message;
  final DateTime? createdAt;

  ContactModel({
    this.id,
    required this.name,
    required this.email,
    required this.message,
    this.createdAt,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      message: json['message'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'message': message,
    };
  }
}
