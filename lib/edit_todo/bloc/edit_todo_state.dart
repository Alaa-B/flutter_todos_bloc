// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_todo_bloc.dart';

enum EditTodoStatus { initial, loading, success, failure }

// Return if the status is loading or success
extension EditTodoStatusZ on EditTodoStatus {
  bool get isLoadingOrSuccess => [
        EditTodoStatus.loading,
        EditTodoStatus.success,
      ].contains(this);
}

class EditTodoState extends Equatable {
  const EditTodoState({
    this.status = EditTodoStatus.initial,
    this.tittle = '',
    this.description = '',
    this.initialTodo,
  });
  final EditTodoStatus status;
  final String tittle;
  final String description;
  final Todo? initialTodo;

  bool get isNewTodo => initialTodo == null;

  @override
  List<Object?> get props => [
        status,
        tittle,
        description,
        initialTodo,
      ];

  EditTodoState copyWith({
    EditTodoStatus? status,
    String? tittle,
    String? description,
    Todo? initialTodo,
  }) {
    return EditTodoState(
      status: status ?? this.status,
      tittle: tittle ?? this.tittle,
      description: description ?? this.description,
      initialTodo: initialTodo ?? this.initialTodo,
    );
  }
}
