import 'package:equatable/equatable.dart';

class Hobby extends Equatable {
  final String id;
  final String name;

  const Hobby({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}