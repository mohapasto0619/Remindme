import 'package:remind_me/data/entities/db_entities/todo.dart';
import 'package:remind_me/data/sources/db_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_repository.g.dart';

@Riverpod(keepAlive: true)
TodoRepository todoRepository(TodoRepositoryRef ref) {
  final appDbClient = ref.watch(appDbClientProvider);
  return TodoRepository(appDbClient: appDbClient);
}

class TodoRepository {
  const TodoRepository({
    required AppDbClient appDbClient,
  }) : _appDbClient = appDbClient;

  final AppDbClient _appDbClient;

  Future<void> saveTodo(Todo newTodo) async {
    _appDbClient.saveTodo(newTodo);
  }

  Future<List<Todo>> getAllTodos() async {
    return _appDbClient.getAllTodos();
  }

  Stream<List<Todo>> listenTodos() async* {
    yield* _appDbClient.listenToTodos();
  }
}
