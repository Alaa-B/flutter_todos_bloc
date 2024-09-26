import '../todos_api.dart';

/// {@template todos_api}
/// The interface and models for an API providing access to todos.
/// {@endtemplate}
abstract class TodosApi {
  /// {@macro todos_api}
  const TodosApi();

  Stream<List<Todo>> getsTodo();
  Future<void> saveToDo(Todo todo);
  Future<void> deleteTodo(String id);
  Future<int> clearCompleted();
  Future<int> completeAll({required bool isCompleted});
  Future<void> close();
}

///threw excepton when [Todo] id is not found.
class TodoNotFoundException implements Exception {}
