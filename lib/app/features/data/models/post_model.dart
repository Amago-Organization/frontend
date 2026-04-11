import 'package:pulse_post/app/features/data/models/user_summary_model.dart';
import 'package:pulse_post/app/features/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  const PostModel({
    required super.id,
    required super.title,
    required super.description,
    required super.createdAt,
    super.file,
    required super.postType,
    super.updateAt,
    required super.user,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'postType': postType,
      'file': file,
      'createdAt': createdAt,
      'updateAt': updateAt,
      'user': user,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      postType: map['postType'] as String,
      file: map['file'] != null ? map['file'] as String : null,
      createdAt: map['createdAt'] as String,
      updateAt: map['updateAt'] != null ? map['updateAt'] as String : null,
      user: UserSummaryModel.fromMap(map['user'] as Map<String, dynamic>),
    );
  }
}
