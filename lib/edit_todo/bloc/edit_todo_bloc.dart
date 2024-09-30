import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_repository/todos_repository.dart';

part 'edit_todo_event.dart';
part 'edit_todo_state.dart';

class EditTodoBloc extends Bloc<EditTodoEvent, EditTodoState> {
  EditTodoBloc({
    required TodosRepository todoRepository,
    Todo? initialTodo,
  })  : _todosRepository = todoRepository,
        super(
          EditTodoState(
            initialTodo: initialTodo,
            tittle: initialTodo?.title ?? '',
            description: initialTodo?.description ?? '',
          ),
        ) {
    on<EditTodoTittleChanged>(_onTittleChanged);
    on<EditTodoDescriptionChanged>(_onDescriptionChanged);
    on<EditTodoSubmitted>(_onSubmitted);
  }

  final TodosRepository _todosRepository;

  void _onTittleChanged(
    EditTodoTittleChanged event,
    Emitter<EditTodoState> emit,
  ) {
    emit(state.copyWith(tittle: event.tittle));
  }

  void _onDescriptionChanged(
    EditTodoDescriptionChanged event,
    Emitter<EditTodoState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _onSubmitted(
    EditTodoSubmitted event,
    Emitter<EditTodoState> emit,
  ) async {
    emit(
      state.copyWith(
        status: EditTodoStatus.loading,
      ),
    );
    final todo = state.initialTodo ??
        Todo(title: '').copyWith(
          title: state.tittle,
          description: state.description,
        );
    try {
      await _todosRepository.saveTodo(todo);
      emit(state.copyWith(status: EditTodoStatus.success));
    } catch (_) {
      emit(state.copyWith(status: EditTodoStatus.failure));
    }
  }
}
