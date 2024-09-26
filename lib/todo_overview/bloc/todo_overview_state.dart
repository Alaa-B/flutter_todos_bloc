part of 'todo_overview_bloc.dart';

sealed class TodoOverviewState extends Equatable {
  const TodoOverviewState();
  
  @override
  List<Object> get props => [];
}

final class TodoOverviewInitial extends TodoOverviewState {}
