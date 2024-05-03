part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeInitial extends HomeEvent {
  final PageController pageController;
  const HomeInitial({required this.pageController});
  @override
  List<Object> get props => [pageController];
}

class HomeNavigate extends HomeEvent {
  final int index;
  const HomeNavigate({required this.index});
  @override
  List<Object> get props => [index];
}

class HomeUpdateIndex extends HomeEvent {
  final int index;
  const HomeUpdateIndex({required this.index});

  @override
  List<Object> get props => [index];
}

class HomeReset extends HomeEvent {
  const HomeReset();

  @override
  List<Object> get props => [];
}