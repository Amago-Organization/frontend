import 'package:amago/app/features/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.createdAt,
    super.bio,
    super.image,
    super.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'bio': bio,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      bio: map['bio'] != null ? map['bio'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }
}
