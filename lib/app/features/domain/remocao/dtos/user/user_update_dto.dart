import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserUpdateDto {
  final String? name;
  final String? bio;
  UserUpdateDto({
    this.name,
    this.bio,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'bio': bio,
    };
  }

  factory UserUpdateDto.fromMap(Map<String, dynamic> map) {
    return UserUpdateDto(
      name: map['name'] != null ? map['name'] as String : null,
      bio: map['bio'] != null ? map['bio'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserUpdateDto.fromJson(String source) => UserUpdateDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant UserUpdateDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.bio == bio;
  }

  @override
  int get hashCode => name.hashCode ^ bio.hashCode;

  @override
  String toString() => 'UserUpdateDto(name: $name, bio: $bio)';
}
