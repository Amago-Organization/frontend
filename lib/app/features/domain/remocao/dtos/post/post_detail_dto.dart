// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:pulse_post/app/features/domain/remocao/dtos/user/user_summary_dto.dart';

class PostDetailDto {
  final String id;
  final String title;
  final String description;
  final String postType;
  final String? file;
  final String createdAt;
  final String? updatedAt;
  final UserSummaryDto user;
  PostDetailDto({
    required this.id,
    required this.title,
    required this.description,
    required this.postType,
    this.file,
    required this.createdAt,
    this.updatedAt,
    required this.user,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'postType': postType,
      'file': file,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'user': user.toMap(),
    };
  }

  factory PostDetailDto.fromMap(Map<String, dynamic> map) {
    return PostDetailDto(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      postType: map['postType'] as String,
      file: map['file'] != null ? map['file'] as String : null,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      user: UserSummaryDto.fromMap(map['user'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory PostDetailDto.fromJson(String source) => PostDetailDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostDetailDto(id: $id, title: $title, description: $description, postType: $postType, file: $file, createdAt: $createdAt, updatedAt: $updatedAt, user: $user)';
  }

  @override
  bool operator ==(covariant PostDetailDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.postType == postType &&
      other.file == file &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt &&
      other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      postType.hashCode ^
      file.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      user.hashCode;
  }
}
