part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();
}

final class SettingsChangeRedColor extends SettingsEvent {
  final int value;
  const SettingsChangeRedColor(this.value);
  @override
  List<Object> get props => [value];
}

final class SettingsChangeGreenColor extends SettingsEvent {
  final int value;
  const SettingsChangeGreenColor(this.value);
  @override
  List<Object> get props => [value];
}

final class SettingsChangeBlueColor extends SettingsEvent {
  final int value;
  const SettingsChangeBlueColor(this.value);
  @override
  List<Object> get props => [value];
}


final class SettingsChangeTheme extends SettingsEvent {
  final int index;
  const SettingsChangeTheme(this.index);
  @override
  List<Object> get props => [index];
}

final class SettingsChangeLanguage extends SettingsEvent {
  final String code;
  const SettingsChangeLanguage(this.code);
  @override
  List<Object> get props => [code];
}

final class SettingsSave extends SettingsEvent {
  const SettingsSave();
  @override
  List<Object> get props => [];
}
