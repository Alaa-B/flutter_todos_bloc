part of 'todo_overview_bloc.dart';

sealed class TodoOverviewEvent extends Equatable {
  const TodoOverviewEvent();

  @override
  List<Object> get props => [];
}

final class TodosOverviewSubscriptionRequested extends TodoOverviewEvent {
  const TodosOverviewSubscriptionRequested();
}

final class TodoOverviewCompletionToggled extends TodoOverviewEvent {
  const TodoOverviewCompletionToggled({
    required this.todo,
    required this.isCompleted,
  });

  final Todo todo;
  final bool isCompleted;
  @override
  List<Object> get props => [todo, isCompleted];
}

final class TodoOverviewTodoDeleted extends TodoOverviewEvent {
  const TodoOverviewTodoDeleted({required this.todo});

  final Todo todo;
  @override
  List<Object> get props => [todo];
}

final class TodosOverviewUndoDeletionRequested extends TodoOverviewEvent {
  const TodosOverviewUndoDeletionRequested();
}

class TodosOverviewToggleAllRequested extends TodoOverviewEvent {
  const TodosOverviewToggleAllRequested();
}

class TodosOverviewClearCompletedRequested extends TodoOverviewEvent {
  const TodosOverviewClearCompletedRequested();
}

class TodosOverviewFilterChanged extends TodoOverviewEvent {
  const TodosOverviewFilterChanged(this.filter);

  final TodosStatusFilter filter;

  @override
  List<Object> get props => [filter];
}
