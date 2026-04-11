// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PostRegisterDto {
  final String title;
  final String description;
  PostRegisterDto({
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
    };
  }

  factory PostRegisterDto.fromMap(Map<String, dynamic> map) {
    return PostRegisterDto(
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostRegisterDto.fromJson(String source) => PostRegisterDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant PostRegisterDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.description == description;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode;

  @override
  String toString() => 'PostRegisterDto(title: $title, description: $description)';
}
