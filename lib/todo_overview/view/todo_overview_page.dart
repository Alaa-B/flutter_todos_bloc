import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos_bloc/l10n/l10n.dart';
import 'package:flutter_todos_bloc/todo_overview/bloc/todo_overview_bloc.dart';
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
        title: Text(''),
      ),
    );
  }
}
