/// Model for a registered user.
class RegisteredUser {
  const RegisteredUser({
    required this.username,
    required this.email,
    required this.age,
  });

  final String username;
  final String email;
  final int age;

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'age': age,
      };

  factory RegisteredUser.fromJson(Map<String, dynamic> json) {
    return RegisteredUser(
      username: json['username'] as String,
      email: json['email'] as String,
      age: json['age'] as int,
    );
  }
}
