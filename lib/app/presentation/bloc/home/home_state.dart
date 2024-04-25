part of 'home_bloc.dart';

class HomeState extends Equatable {
  final PageController? pageController;
  final int index;
  const HomeState({this.index = 0, this.pageController});

  @override
  List<Object?> get props => [index, pageController];

  HomeState copyWith({int? index, PageController? pageController}) {
    return HomeState(
      index: index ?? this.index,
      pageController: pageController ?? this.pageController,
    );
  }
}
