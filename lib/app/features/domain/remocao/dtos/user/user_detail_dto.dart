import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserDetailDto {
  final String id;
  final String name;
  final String email;
  final String? bio;
  final String? image;
  final String created;
  final String? updated;
  UserDetailDto({
    required this.id,
    required this.name,
    required this.email,
    this.bio,
    this.image,
    required this.created,
    this.updated,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'bio': bio,
      'image': image,
      'created': created,
      'updated': updated,
    };
  }

  factory UserDetailDto.fromMap(Map<String, dynamic> map) {
    return UserDetailDto(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      bio: map['bio'] != null ? map['bio'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      created: map['created'] as String,
      updated: map['updated'] != null ? map['updated'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetailDto.fromJson(String source) => UserDetailDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserDetailDto(id: $id, name: $name, email: $email, bio: $bio, image: $image, created: $created, updated: $updated)';
  }

  @override
  bool operator ==(covariant UserDetailDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.bio == bio &&
      other.image == image &&
      other.created == created &&
      other.updated == updated;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      bio.hashCode ^
      image.hashCode ^
      created.hashCode ^
      updated.hashCode;
  }
}
