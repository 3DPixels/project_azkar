part of 'settings_cubit.dart';

// Using Equatable to compare states.
class SettingsState extends Equatable {
  final ThemeMode themeMode;
  final bool notificationsEnabled;

  const SettingsState({
    this.themeMode = ThemeMode.system, // A sensible default
    this.notificationsEnabled = true,
  });

  // copyWith allows us to create a new state instance with updated values.
  SettingsState copyWith({ThemeMode? themeMode, bool? notificationsEnabled}) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }

  @override
  List<Object> get props => [themeMode, notificationsEnabled];
}
