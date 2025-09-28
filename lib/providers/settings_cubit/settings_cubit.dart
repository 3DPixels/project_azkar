import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../services/cache_helper.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState()) {
    // Load saved settings when the cubit is created.
    getSavedThemeMode();
  }

  void getSavedThemeMode() {
    final bool isDarkMode = CacheHelper.getThemeMode();
    final themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    // Emit a new state with the loaded theme.
    emit(state.copyWith(themeMode: themeMode));
  }

  Future<void> changeTheme() async {
    final newTheme = state.themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    // First, emit the new state to update the UI instantly.
    emit(state.copyWith(themeMode: newTheme));

    // Then, save the preference asynchronously.
    await CacheHelper.cacheThemeMode(newTheme == ThemeMode.dark);
  }

  void toggleNotifications() {
    // Emit a new state with the toggled boolean value.
    emit(state.copyWith(notificationsEnabled: !state.notificationsEnabled));
    // You could also save this to CacheHelper here if needed.
  }
}
