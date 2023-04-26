import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:remind_me/data/entities/db_entities/todo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'db_client.g.dart';

@Riverpod(keepAlive: true)
AppDbClient appDbClient(AppDbClientRef ref) {
  return AppDbClient();
}

class AppDbClient {
  AppDbClient() {
    instance = openDB();
  }
  late Future<Isar> instance;

  Future<void> saveTodo(Todo newTodo) async {
    final db = await instance;
    db.writeTxnSync<int>(() => db.todos.putSync(newTodo));
  }

  Future<List<Todo>> getAllTodos() async {
    final db = await instance;
    return db.todos.where().findAll();
  }

  Stream<List<Todo>> listenToTodos() async* {
    final db = await instance;
    yield* db.todos.where().watch(fireImmediately: true);
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return Isar.open([TodoSchema], inspector: true, directory: dir.path);
    }

    return Future.value(Isar.getInstance());
  }
}
