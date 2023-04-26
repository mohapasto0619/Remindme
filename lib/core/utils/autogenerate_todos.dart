import 'package:faker/faker.dart';
import 'package:isar/isar.dart';
import 'package:remind_me/data/entities/db_entities/todo.dart';

List<Todo> autogenerateTodos(int itemNumber) {
  final faker = Faker();
  final List<Todo> todos = [];
  for (int i = 0; i < itemNumber; i++) {
    final todo = Todo(
      id: Isar.autoIncrement,
      title: faker.job.title(),
      description: faker.lorem.words(40).toString(),
      done: faker.randomGenerator.boolean(),
    );
    /*..title = faker.job.title()
      ..description = faker.lorem.words(40).toString()
      ..done = faker.randomGenerator.boolean();*/
    todos.add(todo);
  }
  return todos;
}
