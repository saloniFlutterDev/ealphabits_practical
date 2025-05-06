class LocalUserModel {
  final String? id;
  final String? email;
  final String? firstName;

  LocalUserModel({
    this.id,
    this.email,
    this.firstName,
  });

  factory LocalUserModel.fromJson(Map<String, dynamic> json) {
    return LocalUserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
    };
  }
}
