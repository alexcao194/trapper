import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState.initial()) {
    on<SettingsChangeBlueColor>(_onChangeBlueColor);
    on<SettingsChangeGreenColor>(_onChangeGreenColor);
    on<SettingsChangeRedColor>(_onChangeRedColor);
    on<SettingsChangeTheme>(_onChangeTheme);
    on<SettingsChangeLanguage>(_onChangeLanguage);
    on<SettingsSave>(_onSave);
  }

  var seek = const Color(0xFF000000);
  var themeIndex = 0;
  var languageCode = 'en';

  FutureOr<void> _onChangeBlueColor(SettingsChangeBlueColor event, Emitter<SettingsState> emit) {
    emit(state.copyWith(blueColor: event.value));
    seek = Color.fromARGB(255, state.redColor, state.greenColor, event.value);
  }

  FutureOr<void> _onChangeGreenColor(SettingsChangeGreenColor event, Emitter<SettingsState> emit) {
    emit(state.copyWith(greenColor: event.value));
    seek = Color.fromARGB(255, state.redColor, event.value, state.blueColor);
  }

  FutureOr<void> _onChangeRedColor(SettingsChangeRedColor event, Emitter<SettingsState> emit) {
    emit(state.copyWith(redColor: event.value));
    seek = Color.fromARGB(255, event.value, state.greenColor, state.blueColor);
  }

  FutureOr<void> _onChangeTheme(SettingsChangeTheme event, Emitter<SettingsState> emit) {
    emit(state.copyWith(themeIndex: event.index));
    themeIndex = event.index;
  }

  FutureOr<void> _onChangeLanguage(SettingsChangeLanguage event, Emitter<SettingsState> emit) {
    emit(state.copyWith(languageCode: event.code));
    languageCode = event.code;
  }

  FutureOr<void> _onSave(SettingsSave event, Emitter<SettingsState> emit) {
    emit(state.copyWith(
      currentThemeIndex: themeIndex,
      currentLanguageCode: languageCode,
      seek: seek,
    ));
  }
}
