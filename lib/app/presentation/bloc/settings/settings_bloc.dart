import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trapper/app/domain/entity/settings_snapshot.dart';

import '../../../domain/use_case/fetch_settings.dart';
import '../../../domain/use_case/save_settings.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  late FetchSettings _fetchSettings;
  late SaveSettings _saveSettings;
  SettingsBloc({
    required FetchSettings fetchSettings,
    required SaveSettings saveSettings
  }) : super(SettingsState.initial()) {
    _fetchSettings = fetchSettings;
    _saveSettings = saveSettings;
    on<SettingsChangeBlueColor>(_onChangeBlueColor);
    on<SettingsChangeGreenColor>(_onChangeGreenColor);
    on<SettingsChangeRedColor>(_onChangeRedColor);
    on<SettingsChangeTheme>(_onChangeTheme);
    on<SettingsChangeLanguage>(_onChangeLanguage);
    on<SettingsSave>(_onSave);
    on<SettingsFetch>(_onFetch);

    add(const SettingsFetch());
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

     _saveSettings(SettingsSnapshot(
      red: state.redColor,
      green: state.greenColor,
      blue: state.blueColor,
      themeIndex: themeIndex,
      languageCode: languageCode,
    ));

    emit(state.copyWith(
      settingsSnapshot: SettingsSnapshot(
        red: state.redColor,
        green: state.greenColor,
        blue: state.blueColor,
        themeIndex: themeIndex,
        languageCode: languageCode,
      ),
    ));
  }

  FutureOr<void> _onFetch(SettingsFetch event, Emitter<SettingsState> emit) async {
    var settingsSnapshot = await _fetchSettings();
    settingsSnapshot.fold(
      (l) => (),
      (r) => emit(state.copyWith(
        redColor: r.red,
        greenColor: r.green,
        blueColor: r.blue,
        themeIndex: r.themeIndex,
        languageCode: r.languageCode,
        settingsSnapshot: r,
      )),
    );
  }
}
