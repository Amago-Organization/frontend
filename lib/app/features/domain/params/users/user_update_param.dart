// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

class UserUpdateParam {
  final String? name;
  final String? bio;
  final File? file;
  UserUpdateParam({
    this.name,
    this.bio,
    this.file,
  });
}
