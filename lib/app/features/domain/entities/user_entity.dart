// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? bio;
  final String? image;
  final String createdAt;
  final String? updatedAt;
  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.bio,
    this.image,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, name, email, bio, image, createdAt, updatedAt];

}
