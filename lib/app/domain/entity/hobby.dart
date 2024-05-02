import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'hobby.g.dart';

@HiveType(typeId: 2)
class Hobby extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;

  const Hobby({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}