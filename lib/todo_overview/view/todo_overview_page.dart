import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos_bloc/edit_todo/view/edit_todo_page.dart';
import 'package:flutter_todos_bloc/l10n/l10n.dart';
import 'package:flutter_todos_bloc/todo_overview/bloc/todo_overview_bloc.dart';
import 'package:flutter_todos_bloc/todo_overview/widgets/todo_filter_button.dart';
import 'package:flutter_todos_bloc/todo_overview/widgets/todo_list_tile.dart';
import 'package:flutter_todos_bloc/todo_overview/widgets/todo_options_button.dart';
import 'package:todos_repository/todos_repository.dart';

class TodoOverviewPage extends StatelessWidget {
  const TodoOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TodoOverviewBloc(todoRepository: context.read<TodosRepository>())
            ..add(const TodosOverviewSubscriptionRequested()),
      child: const TodoOverviewView(),
    );
  }
}

class TodoOverviewView extends StatelessWidget {
  const TodoOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.todoDetailsAppBarTitle),
        actions: const [
          TodoFilterButton(),
          TodoOptionsButton(),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TodoOverviewBloc, TodoOverviewState>(
            listenWhen: (previous, current) {
              return previous.status != current.status;
            },
            listener: (context, state) {
              if (state.status == TodoOverviewStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(
                        l10n.todosOverviewErrorSnackbarText,
                      ),
                    ),
                  );
              }
            },
          ),
          BlocListener<TodoOverviewBloc, TodoOverviewState>(
            listenWhen: (previous, current) {
              return current.lastDeletedTodo != previous.lastDeletedTodo &&
                  current.lastDeletedTodo != null;
            },
            listener: (context, state) {
              final lastDeletedTodo = state.lastDeletedTodo!;
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      l10n.todosOverviewTodoDeletedSnackbarText(
                        lastDeletedTodo.title,
                      ),
                    ),
                    action: SnackBarAction(
                      label: l10n.todosOverviewUndoDeletionButtonText,
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        context
                            .read<TodoOverviewBloc>()
                            .add(const TodosOverviewUndoDeletionRequested());
                      },
                    ),
                  ),
                );
            },
          ),
        ],
        child: BlocBuilder<TodoOverviewBloc, TodoOverviewState>(
          builder: (context, state) {
            if (state.todos.isEmpty) {
              if (state.status == TodoOverviewStatus.loading) {
                return const CircularProgressIndicator.adaptive();
              } else if (state.status != TodoOverviewStatus.success) {
                return const SizedBox();
              } else {
                return Center(
                  child: Text(
                    l10n.todosOverviewEmptyText,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              }
            }
            return Scrollbar(
              child: ListView(
                children: [
                  for (final todo in state.filteredTodos)
                    TodoListTile(
                      todo: todo,
                      onDismissComplete: (isCompleted) =>
                          context.read<TodoOverviewBloc>().add(
                                TodoOverviewCompletionToggled(
                                  todo: todo,
                                  isCompleted: isCompleted,
                                ),
                              ),
                      onDismissed: (_) {
                        context
                            .read<TodoOverviewBloc>()
                            .add(TodoOverviewTodoDeleted(todo: todo));
                      },
                      onTap: () =>
                          Navigator.of(context).push(EditTodoPage.route(todo)),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
