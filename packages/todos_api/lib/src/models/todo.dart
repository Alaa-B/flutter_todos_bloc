import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:todos_api/todos_api.dart';
import 'package:uuid/uuid.dart';

part 'todo.g.dart';

@immutable
@JsonSerializable()
class Todo extends Equatable {
  Todo({
    required this.title,
    String? id,
    this.descreption = '',
    this.isComplete = false,
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or not empty',
        ),
        id = id ?? const Uuid().v4();

  final String id;
  final String title;
  final String descreption;
  final bool isComplete;

  static Todo fromJson(JsonMap json) => _$TodoFromJson(json);
  JsonMap toJson() => _$TodoToJson(this);

  Todo copyWith({
    String? id,
    String? title,
    String? descreption,
    bool? isComplete,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      descreption: descreption ?? this.descreption,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  @override
  List<Object?> get props => [id, title, descreption, isComplete];
}
