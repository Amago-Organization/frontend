import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserTokenDto {
  final String? token;
  UserTokenDto({
    this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
    };
  }

  factory UserTokenDto.fromMap(Map<String, dynamic> map) {
    return UserTokenDto(
      token: map['token'] != null ? map['token'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserTokenDto.fromJson(String source) => UserTokenDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant UserTokenDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.token == token;
  }

  @override
  int get hashCode => token.hashCode;

  @override
  String toString() => 'UserTokenDto(token: $token)';
}
