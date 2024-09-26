part of 'home_cubit.dart';

enum HomeTabs { todos, stats }

final class HomeState extends Equatable {
  const HomeState({
    this.homeTabs = HomeTabs.todos,
  });
  final HomeTabs homeTabs;
  @override
  List<Object> get props => [homeTabs];
}
