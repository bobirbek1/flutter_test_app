import 'package:equatable/equatable.dart';
import 'package:flutter_test_app/model.dart';

abstract class UserState extends Equatable {}

class Initial extends UserState {
  @override
  List<Object?> get props => [];
}

class Loading extends UserState {
  @override
  List<Object?> get props => [];
}

class Loaded extends UserState {
  final List<User> users;
  Loaded({required this.users});
  @override
  List<Object?> get props => [users];
}

class Error extends UserState {
  final String? error;

  Error({this.error});

  @override
  List<Object?> get props => [error];
}
