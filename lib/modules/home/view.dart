import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remind_me/core/utils/autogenerate_todos.dart';
import 'package:remind_me/data/entities/db_entities/todo.dart';
import 'package:remind_me/data/repositories/todo_repository.dart';
import 'package:remind_me/modules/todo/view.dart';
import 'package:remind_me/modules/todos/view.dart';
import 'package:remind_me/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view.g.dart';

@Riverpod(keepAlive: false)
List<Todo> generatedTodos(GeneratedTodosRef ref) {
  final todos = autogenerateTodos(100000);
  return todos;
}

/*Future<void> saveTodos(WidgetRef ref) async {
  final todos = ref.read(generatedTodosProvider);
  todos.forEach((todo) {
    ref.read(todoRepositoryProvider).saveTodo(todo);
  });
}*/

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(generatedTodosProvider);
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Paul todo's",
        ),
        backgroundColor: AppColors.darkBlue,
      ),
      body: const TodosView(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'FloatingTag1',
            onPressed: () {
              todos.forEach((todo) {
                ref.read(todoRepositoryProvider).saveTodo(todo);
              }); //TODO: find a way to use compute with riverpod
              //compute<WidgetRef, void>(saveTodos, ref);
              /*compute<List<Todo>, void>((message) {
                message.forEach((todo) {
                  ref.read(todoRepositoryProvider).saveTodo(todo);
                });
              }, todos);*/
              /*(message) {
                print(message.toString());
                todos.forEach((todo) {
                  ref.read(todoRepositoryProvider).saveTodo(todo);
                });
              }*/
            },
            backgroundColor: AppColors.darkBlue,
            child: const Icon(Icons.auto_awesome_motion_outlined),
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            heroTag: 'FloatingTag2',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (context) => const TodoView()),
              );
            },
            backgroundColor: AppColors.darkBlue,
            child: const Icon(Icons.add_box_outlined),
          ),
        ],
      ),
    );
  }
}
