import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserLoginDto {
  final String email;
  final String password;
  UserLoginDto({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory UserLoginDto.fromMap(Map<String, dynamic> map) {
    return UserLoginDto(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLoginDto.fromJson(String source) => UserLoginDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant UserLoginDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;

  @override
  String toString() => 'UserLoginDto(email: $email, password: $password)';
}
