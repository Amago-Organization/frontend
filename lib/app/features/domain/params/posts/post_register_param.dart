// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

class PostRegisterParam {
  final String title;
  final String description;
  final File? file;
  PostRegisterParam({
    required this.title,
    required this.description,
    this.file,
  });
}
