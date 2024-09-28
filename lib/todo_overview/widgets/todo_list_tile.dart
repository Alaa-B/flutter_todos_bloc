import 'package:flutter/material.dart';
import 'package:todos_repository/todos_repository.dart';

class TodoListTile extends StatelessWidget {
  const TodoListTile({
    required this.todo,
    this.onDissmissed,
    this.onDismissComplete,
    this.onTap,
    super.key,
  });

  final Todo todo;
  final DismissDirectionCallback? onDissmissed;
  final ValueChanged<bool>? onDismissComplete;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final captionColor = theme.textTheme.bodySmall?.color;

    return Dismissible(
      key: Key('dismissible_key${todo.id}'),
      onDismissed: onDissmissed,
      child: ListTile(
        onTap: onTap,
        title: Text(
          todo.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: !todo.isComplete
              ? null
              : TextStyle(
                  color: captionColor,
                  decoration: TextDecoration.lineThrough,
                ),
        ),
        subtitle: Text(
          todo.descreption,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: Checkbox.adaptive(
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          value: todo.isComplete,
          onChanged: onDismissComplete == null
              ? null
              : (value) => onDismissComplete!(value!),
        ),
        trailing:
            onTap == null ? null : const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
