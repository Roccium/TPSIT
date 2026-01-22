import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'model.dart';
import 'notifier.dart';

final mate = math.Random();

class TodoItem extends StatelessWidget {
  TodoItem({required this.todo}) : super(key: ObjectKey(todo));

  final Todo todo;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black45,
      decoration: TextDecoration.overline,
    );
  }

  @override
  Widget build(BuildContext context) {
    final TodoListNotifier notifier = context.watch<TodoListNotifier>();
    return Row(children: <Widget>[
      Expanded(
        child: CheckboxListTile(
          title: Text(todo.name),
          value: todo.checked,
          onChanged: (newValue) {
            notifier.changeTodo(todo);
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
      Expanded(
          child:
              ElevatedButton(onPressed: null, child: const Text('Disabled'))),
    ]);
  }
}

class ContenitoreItem extends StatelessWidget {
  ContenitoreItem({required this.contenitore})
      : super(key: ObjectKey(contenitore));

  final Contenitore contenitore;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text("4"),
      value: true,
      onChanged: (newValue) {},
      controlAffinity: ListTileControlAffinity.leading,
    ); /*Container(
      height: 100,
      width: 100,
      color: Color((mate.nextDouble() * 0xFFFFFF).toInt()),
    );*/
  }
}
