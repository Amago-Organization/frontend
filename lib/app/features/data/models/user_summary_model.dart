import 'package:amago/app/features/domain/entities/user_sumary_entity.dart';

class UserSummaryModel extends UserSummaryEntity {
  const UserSummaryModel({required super.id, required super.name, super.image});
  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name, 'image': image};
  }

  factory UserSummaryModel.fromMap(Map<String, dynamic> map) {
    return UserSummaryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }
}
