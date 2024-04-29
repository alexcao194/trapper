import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeInitial>(_onInitial);
    on<HomeNavigate>(_onNavigate);
    on<HomeUpdateIndex>(_onUpdateIndex);
  }

  FutureOr<void> _onNavigate(HomeNavigate event, Emitter<HomeState> emit) async {
    if (state.pageController != null) {
      state.pageController!.jumpToPage(event.index);
    }
    emit(state.copyWith(index: event.index));
  }

  FutureOr<void> _onInitial(HomeInitial event, Emitter<HomeState> emit) {
    emit(state.copyWith(pageController: event.pageController));
    event.pageController.addListener(() {
      final index = event.pageController.page?.round();
      if (index != null && index != state.index) {
        add(HomeUpdateIndex(index: index));
      }
    });
  }

  FutureOr<void> _onUpdateIndex(HomeUpdateIndex event, Emitter<HomeState> emit) {
    emit(state.copyWith(index: event.index));
  }
}
