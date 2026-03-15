import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.username,
    required super.email,
    required super.age,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] as String,
      email: json['email'] as String,
      age: json['age'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'age': age,
      };

  factory UserModel.fromEntity(User user) {
    return UserModel(
      username: user.username,
      email: user.email,
      age: user.age,
    );
  }
}
