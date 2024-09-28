// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'stats_bloc.dart';

@visibleForTesting
enum StatsStatus { initial, loading, success, failure }

final class StatsState extends Equatable {
  const StatsState({
    this.statsStatus = StatsStatus.initial,
    this.completedTodos = 0,
    this.activeTodos = 0,
  });

  final StatsStatus statsStatus;
  final int completedTodos;
  final int activeTodos;

  @override
  List<Object> get props => [statsStatus, completedTodos, activeTodos];

  StatsState copyWith({
    StatsStatus? statsStatus,
    int? completedTodos,
    int? activeTodos,
  }) {
    return StatsState(
      statsStatus: statsStatus ?? this.statsStatus,
      completedTodos: completedTodos ?? this.completedTodos,
      activeTodos: activeTodos ?? this.activeTodos,
    );
  }
}
