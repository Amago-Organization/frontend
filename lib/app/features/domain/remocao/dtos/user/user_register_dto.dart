import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserRegisterDto {
  final String name;
  final String email;
  final String password;
  UserRegisterDto({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory UserRegisterDto.fromMap(Map<String, dynamic> map) {
    return UserRegisterDto(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRegisterDto.fromJson(String source) => UserRegisterDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant UserRegisterDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ password.hashCode;

  @override
  String toString() => 'UserRegisterDto(name: $name, email: $email, password: $password)';
}
