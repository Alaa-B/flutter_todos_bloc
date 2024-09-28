import 'package:todos_api/todos_api.dart';

/// {@template todos_repository}
// A repository that handles `todo` related requests.
/// {@endtemplate}

class TodosRepository {
  /// {@macro todos_repository}
  const TodosRepository({required TodosApi todosApi}) : _todosApi = todosApi;
  final TodosApi _todosApi;

  Stream<List<Todo>> getTodos() => _todosApi.getsTodo();
  Future<void> deleteTodos(String id) => _todosApi.deleteTodo(id);
  Future<void> saveTodo(Todo todo) => _todosApi.saveToDo(todo);
  Future<int> clearCompleted() => _todosApi.clearCompleted();
  Future<int> completeAll({required bool isCompleted}) =>
      _todosApi.completeAll(isCompleted: isCompleted);
}
