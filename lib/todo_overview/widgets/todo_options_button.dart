import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos_bloc/l10n/l10n.dart';
import 'package:flutter_todos_bloc/todo_overview/bloc/todo_overview_bloc.dart';

enum Options { toggleAll, clearAllCompleted }

class TodoOptionsButton extends StatelessWidget {
  const TodoOptionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final todos = context.select((TodoOverviewBloc bloc) => bloc.state.todos);
    final hasTodos = todos.isNotEmpty;
    final totalCompletedTodos = todos.where((todo) => todo.isComplete).length;
    return PopupMenuButton<Options>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      tooltip: l10n.todosOverviewFilterTooltip,
      onSelected: (value) {
        switch (value) {
          case Options.toggleAll:
            context
                .read<TodoOverviewBloc>()
                .add(const TodosOverviewToggleAllRequested());
          case Options.clearAllCompleted:
            context
                .read<TodoOverviewBloc>()
                .add(const TodosOverviewClearCompletedRequested());
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: Options.toggleAll,
            enabled: hasTodos,
            child: Text(
              totalCompletedTodos == todos.length
                  ? l10n.todosOverviewOptionsMarkAllIncomplete
                  : l10n.todosOverviewOptionsMarkAllComplete,
            ),
          ),
          PopupMenuItem(
            value: Options.clearAllCompleted,
            enabled: hasTodos && totalCompletedTodos != 0,
            child: Text(l10n.todosOverviewOptionsClearCompleted),
          ),
        ];
      },
      icon: const Icon(Icons.more_vert_rounded),
    );
  }
}
