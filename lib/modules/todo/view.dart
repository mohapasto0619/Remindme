import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:remind_me/data/entities/db_entities/todo.dart';
import 'package:remind_me/data/repositories/todo_repository.dart';
import 'package:remind_me/theme/app_colors.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view.g.dart';

@Riverpod(keepAlive: false)
class CheckboxValue extends _$CheckboxValue {
  @override
  bool build() {
    return false;
  }

  void updateValue({required bool value}) {
    if (kDebugMode) {
      print(value);
    }
    state = value;
  }
}

@Riverpod(keepAlive: false)
class TitleValue extends _$TitleValue {
  @override
  String build() {
    return '';
  }

  void updateValue({required String value}) {
    if (kDebugMode) {
      print(value);
    }
    state = value;
  }
}

@Riverpod(keepAlive: false)
class DescriptionValue extends _$DescriptionValue {
  @override
  String build() {
    return '';
  }

  void updateValue({required String value}) {
    if (kDebugMode) {
      print(value);
    }
    state = value;
  }
}

class TodoView extends ConsumerWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(titleValueProvider);
    final description = ref.watch(descriptionValueProvider);
    final isChecked = ref.watch(checkboxValueProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Title...',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    ref
                        .read(titleValueProvider.notifier)
                        .updateValue(value: value);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  minLines: 18,
                  maxLines: 100,
                  decoration: const InputDecoration(
                    hintText: 'Description...',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    ref
                        .read(descriptionValueProvider.notifier)
                        .updateValue(value: value);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Please specify if the task was completed',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      if (value != null) {
                        ref
                            .read(checkboxValueProvider.notifier)
                            .updateValue(value: value);
                      }
                    })
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkBlue,
                      ),
                      onPressed: () {
                        final todo = Todo(
                          id: Isar.autoIncrement,
                          title: title,
                          description: description,
                          done: isChecked,
                        );
                        /*Todo()
                          ..title = title
                          ..description = description
                          ..done = isChecked;*/
                        ref.read(todoRepositoryProvider).saveTodo(todo);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Submit',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.red,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
