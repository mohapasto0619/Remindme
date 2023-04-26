import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part 'todo.g.dart';
part 'todo.freezed.dart';

@freezed
@Collection(ignore: {'copyWith'})
class Todo with _$Todo {
  const Todo._();

  @JsonSerializable()
  const factory Todo({
    required int id,
    required String title,
    required String description,
    required bool done,
  }) = _Todo;

  Id get id => id;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  // Id id = Isar.autoIncrement;
  // late String title;
  // late String description;
  // late bool done;
}
