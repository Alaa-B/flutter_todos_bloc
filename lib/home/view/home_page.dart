import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos_bloc/edit_todo/view/edit_todo_page.dart';
import 'package:flutter_todos_bloc/home/cubit/home_cubit.dart';
import 'package:flutter_todos_bloc/stats/view/stats_page.dart';

import 'package:flutter_todos_bloc/todo_overview/view/todo_overview_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab =
        context.select((HomeCubit cubit) => cubit.state.homeTabs);
    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: const [
          TodoOverviewPage(),
          StatsPage(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        key: const Key('homeView_addTodo_floatingActionButton'),
        onPressed: () => Navigator.of(context).push(EditTodoPage.route()),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _HomeTabButton(
              selectedValue: selectedTab,
              value: HomeTabs.todos,
              icon: const Icon(Icons.list_rounded),
            ),
            _HomeTabButton(
              selectedValue: selectedTab,
              value: HomeTabs.stats,
              icon: const Icon(Icons.show_chart_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    required this.selectedValue,
    required this.value,
    required this.icon,
  });

  final HomeTabs selectedValue;
  final HomeTabs value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<HomeCubit>().setTab(value),
      iconSize: 32,
      color: selectedValue != value
          ? null
          : Theme.of(context).colorScheme.secondary,
      icon: icon,
    );
  }
}
