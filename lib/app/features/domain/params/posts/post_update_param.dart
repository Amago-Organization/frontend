// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

class PostUpdateParam {
  final String id;
  final String? title;
  final String? description;
  final File? file;
  PostUpdateParam({
    required this.id,
    this.title,
    this.description,
    this.file,
  });
}
