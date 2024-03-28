part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final int redColor;
  final int greenColor;
  final int blueColor;
  final int themeIndex;
  final String languageCode;
  final Color seek;
  final int currentThemeIndex;
  final String currentLanguageCode;

  const SettingsState({
    required this.redColor,
    required this.greenColor,
    required this.blueColor,
    required this.themeIndex,
    required this.languageCode,
    required this.seek,
    required this.currentThemeIndex,
    required this.currentLanguageCode,
  });

  factory SettingsState.initial() {
    return const SettingsState(
      redColor: 0,
      greenColor: 0,
      blueColor: 0,
      themeIndex: 0,
      languageCode: 'en',
      seek: Color(0xFF000000),
      currentThemeIndex: 0,
      currentLanguageCode: 'en',
    );
  }

  @override
  List<Object> get props => [redColor, greenColor, blueColor, themeIndex, languageCode, seek, currentThemeIndex, currentLanguageCode];

  SettingsState copyWith({
    int? redColor,
    int? greenColor,
    int? blueColor,
    int? themeIndex,
    String? languageCode,
    Color? seek,
    int? currentThemeIndex,
    String? currentLanguageCode,
  }) {
    return SettingsState(
      redColor: redColor ?? this.redColor,
      greenColor: greenColor ?? this.greenColor,
      blueColor: blueColor ?? this.blueColor,
      themeIndex: themeIndex ?? this.themeIndex,
      languageCode: languageCode ?? this.languageCode,
      seek: seek ?? this.seek,
      currentThemeIndex: currentThemeIndex ?? this.currentThemeIndex,
      currentLanguageCode: currentLanguageCode ?? this.currentLanguageCode,
    );
  }
}
