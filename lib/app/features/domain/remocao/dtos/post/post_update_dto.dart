// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PostUpdateDto {
  final String? title;
  final String? description;
  PostUpdateDto({
    this.title,
    this.description,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
    };
  }

  factory PostUpdateDto.fromMap(Map<String, dynamic> map) {
    return PostUpdateDto(
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostUpdateDto.fromJson(String source) => PostUpdateDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant PostUpdateDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.description == description;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode;

  @override
  String toString() => 'PostUpdateDto(title: $title, description: $description)';
}
