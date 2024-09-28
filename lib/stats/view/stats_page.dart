import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos_bloc/stats/bloc/stats_bloc.dart';
import 'package:flutter_todos_bloc/todo_overview/bloc/todo_overview_bloc.dart';
import 'package:todos_repository/todos_repository.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StatsBloc(todosRepository: context.read<TodosRepository>())
            ..add(
              const StatsSubscriptionRequested(),
            ),
    );
  }
}
