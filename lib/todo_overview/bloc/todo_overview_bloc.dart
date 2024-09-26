import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todos_bloc/todo_overview/models/todo_view_filter.dart';
import 'package:todos_repository/todos_repository.dart';

part 'todo_overview_event.dart';
part 'todo_overview_state.dart';

class TodoOverviewBloc extends Bloc<TodoOverviewEvent, TodoOverviewState> {
  TodoOverviewBloc({required TodosRepository todoRepository})
      : _todosRepository = todoRepository,
        super(const TodoOverviewState()) {
    on<TodosOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<TodoOverviewCompletionToggled>(_onTodoCompletionToggled);
    on<TodoOverviewTodoDeleted>(_onTodoDeleted);
    on<TodosOverviewUndoDeletionRequested>(_onUndoDeletionRequested);
    on<TodosOverviewToggleAllRequested>(_onToggleAllRequested);
    on<TodosOverviewClearCompletedRequested>(_onClearCompletedRequested);
    on<TodosOverviewFilterChanged>(_onFilterChanged);
  }

  final TodosRepository _todosRepository;
  Future<void> _onSubscriptionRequested(
    TodosOverviewSubscriptionRequested event,
    Emitter<TodoOverviewState> emit,
  ) async {
    emit(
      state.copyWith(
        status: () => TodoOverviewStatus.initial,
      ),
    );
    await emit.forEach<List<Todo>>(
      _todosRepository.getTods(),
      onData: (data) => state.copyWith(
        status: () => TodoOverviewStatus.success,
        todos: () => data,
      ),
      onError: (_, __) => state.copyWith(
        status: () => TodoOverviewStatus.filure,
      ),
    );
  }

  Future<void> _onTodoCompletionToggled(
    TodoOverviewCompletionToggled event,
    Emitter<TodoOverviewState> emit,
  ) async {
    final newTodo = event.todo.copyWith(isComplete: event.isCompleted);
    await _todosRepository.saveTodo(newTodo);
  }

  Future<void> _onTodoDeleted(
    TodoOverviewTodoDeleted event,
    Emitter<TodoOverviewState> emit,
  ) async {
    emit(
      state.copyWith(
        lastDeletedTodo: () => event.todo,
      ),
    );
    await _todosRepository.delelteTodos(event.todo.id);
  }

  Future<void> _onUndoDeletionRequested(
    TodosOverviewUndoDeletionRequested event,
    Emitter<TodoOverviewState> emit,
  ) async {
    assert(state.lastDeletedTodo != null, 'the last deleted todo is null');
    emit(
      state.copyWith(
        lastDeletedTodo: () => null,
      ),
    );
    final todo = state.lastDeletedTodo!;

    await _todosRepository.saveTodo(todo);
  }

  Future<void> _onToggleAllRequested(
    TodosOverviewToggleAllRequested event,
    Emitter<TodoOverviewState> emit,
  ) async {
    final areAllCompleted = state.todos.every((todo) => todo.isComplete);
    await _todosRepository.completeAll(isCompleted: !areAllCompleted);
  }

  Future<void> _onClearCompletedRequested(
    TodosOverviewClearCompletedRequested event,
    Emitter<TodoOverviewState> emit,
  ) async {
    await _todosRepository.clearCompleted();
  }

  Future<void> _onFilterChanged(
    TodosOverviewFilterChanged event,
    Emitter<TodoOverviewState> emit,
  ) async {
    emit(
      state.copyWith(
        filter: () => event.filter,
      ),
    );
  }
}
