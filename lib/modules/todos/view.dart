// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remind_me/data/entities/db_entities/todo.dart';
import 'package:remind_me/data/repositories/todo_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view.g.dart';

@Riverpod(keepAlive: false)
Stream<List<Todo>> todos(TodosRef ref) async* {
  print('reexeuted !');
  final todoRepository = ref.watch(todoRepositoryProvider);
  final todos = todoRepository.listenTodos();
  yield* todos;
}

class TodosView extends ConsumerWidget {
  const TodosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('rebuild !');
    final todos = ref.watch(todosProvider);
    return todos.when(
      data: (todos) {
        return Container(
          child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final currentTodo = todos[index];
              return ListTile(
                title: Text(
                  currentTodo.title,
                ),
                subtitle: Text(
                  currentTodo.description,
                  maxLines: 1,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                trailing: currentTodo.done
                    ? Icon(
                        Icons.check_box,
                      )
                    : Icon(Icons.check_box_outline_blank),
              );
            },
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      },
      loading: () {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
