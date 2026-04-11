import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserSummaryDto {
  final String id;
  final String name;
  final String? image;
  UserSummaryDto({
    required this.id,
    required this.name,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory UserSummaryDto.fromMap(Map<String, dynamic> map) {
    return UserSummaryDto(
      id: map['id'] as String,
      name: map['name'] as String,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserSummaryDto.fromJson(String source) => UserSummaryDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant UserSummaryDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.image == image;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ image.hashCode;

  @override
  String toString() => 'UserSummaryDto(id: $id, name: $name, image: $image)';
}
