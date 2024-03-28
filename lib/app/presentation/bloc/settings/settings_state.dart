part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final int redColor;
  final int greenColor;
  final int blueColor;
  final int themeIndex;
  final String languageCode;
  final SettingsSnapshot settingsSnapshot;

  const SettingsState({
    required this.redColor,
    required this.greenColor,
    required this.blueColor,
    required this.themeIndex,
    required this.languageCode,
    required this.settingsSnapshot,
  });

  factory SettingsState.initial() {
    return const SettingsState(
      redColor: 0,
      greenColor: 0,
      blueColor: 0,
      themeIndex: 0,
      languageCode: 'en',
      settingsSnapshot: SettingsSnapshot(
        red: 0,
        green: 0,
        blue: 0,
        themeIndex: 0,
        languageCode: 'en',
      ),
    );
  }

  @override
  List<Object> get props => [redColor, greenColor, blueColor, themeIndex, languageCode, settingsSnapshot];

  SettingsState copyWith({
    int? redColor,
    int? greenColor,
    int? blueColor,
    int? themeIndex,
    String? languageCode,
    SettingsSnapshot? settingsSnapshot,
  }) {
    return SettingsState(
      redColor: redColor ?? this.redColor,
      greenColor: greenColor ?? this.greenColor,
      blueColor: blueColor ?? this.blueColor,
      themeIndex: themeIndex ?? this.themeIndex,
      languageCode: languageCode ?? this.languageCode,
      settingsSnapshot: settingsSnapshot ?? this.settingsSnapshot,
    );
  }
}
