import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model.dart';
import 'notifier.dart';

class ContenitoreItem extends StatelessWidget {
  const ContenitoreItem({
    required this.contenitore,
    required this.onTap,
    super.key,
  });

  final Contenitore contenitore;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final TodoListNotifier notifier = context.watch<TodoListNotifier>();

    return Card(
      margin: const EdgeInsets.all(8.0),
      color: contenitore.colore,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                contenitore.argomento,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              ...contenitore.todos.map((todo) => TodoItem(
                    todo: todo,
                    onDelete: () => notifier.deleteTodo(contenitore, todo),
                    onToggle: () => notifier.changeTodo(todo),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class TodoItem extends StatelessWidget {
  const TodoItem({
    required this.todo,
    required this.onDelete,
    required this.onToggle,
    super.key,
  });

  final Todo todo;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: ListTile(
          title: Text(
            todo.name,
            style: todo.checked
                ? const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.black54,
                  )
                : null,
          ),
          onLongPress: onDelete,
          onTap: onToggle,
        )),
      ],
    );
  }
}
