// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:amago/app/features/domain/entities/user_sumary_entity.dart';

class PostEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String postType;
  final String? file;
  final String createdAt;
  final String? updateAt;
  final UserSummaryEntity user;
  const PostEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.postType,
    this.file,
    required this.createdAt,
    this.updateAt,
    required this.user,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    postType,
    file,
    createdAt,
    updateAt,
    user,
  ];
}
