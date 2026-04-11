import 'package:equatable/equatable.dart';
import 'package:result_dart/result_dart.dart';

abstract class UseCase<Output extends Object, Input> {
  AsyncResult<Output> call(Input params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}