import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todos_repository/todos_repository.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc({required TodosRepository todosRepository})
      : _todosRepository = todosRepository,
        super(const StatsState()) {
    on<StatsSubscriptionRequested>(_onStatsSubscriptionRequested);
  }
  final TodosRepository _todosRepository;

  Future<void> _onStatsSubscriptionRequested(
    StatsEvent event,
    Emitter<StatsState> emit,
  ) async {
    emit(state.copyWith(statsStatus: StatsStatus.loading));
    await emit.forEach<List<Todo>>(
      _todosRepository.getTodos(),
      onData: (todos) {
        return state.copyWith(
          statsStatus: StatsStatus.success,
          completedTodos: todos.where((todo) => todo.isComplete).length,
          activeTodos: todos.where((todo) => todo.isComplete != true).length,
        );
      },
      onError: (_, __) => state.copyWith(statsStatus: StatsStatus.failure),
    );
  }
}
