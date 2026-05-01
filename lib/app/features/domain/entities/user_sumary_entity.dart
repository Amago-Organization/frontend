// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserSummaryEntity extends Equatable {
  final String id;
  final String name;
  final String? image;
  const UserSummaryEntity({
    required this.id,
    required this.name,
    this.image,
  });

  @override
  List<Object?> get props => [id, name, image];
}
