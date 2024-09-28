import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos_bloc/l10n/l10n.dart';
import 'package:flutter_todos_bloc/todo_overview/bloc/todo_overview_bloc.dart';
import 'package:flutter_todos_bloc/todo_overview/models/todo_view_filter.dart';

class TodoFilterButton extends StatelessWidget {
  const TodoFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final currentFilter =
        context.select((TodoOverviewBloc bloc) => bloc.state.filter);
    return PopupMenuButton<TodosViewFilter>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      tooltip: l10n.todosOverviewFilterTooltip,
      initialValue: currentFilter,
      onSelected: (filter) {
        context
            .read<TodoOverviewBloc>()
            .add(TodosOverviewFilterChanged(filter));
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: TodosViewFilter.all,
            child: Text(l10n.todosOverviewFilterAll),
          ),
          PopupMenuItem(
            value: TodosViewFilter.activeOnly,
            child: Text(l10n.todosOverviewFilterActiveOnly),
          ),
          PopupMenuItem(
            value: TodosViewFilter.completedOnly,
            child: Text(l10n.todosOverviewFilterCompletedOnly),
          ),
        ];
      },
      icon: const Icon(Icons.filter_list_rounded),
    );
  }
}
