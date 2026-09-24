part of 'prayer_cubit.dart';

sealed class PrayerState extends Equatable {
  const PrayerState();

  @override
  List<Object?> get props => [];
}

final class PrayerInitial extends PrayerState {}

final class PrayerLoading extends PrayerState {}

final class PrayerLoaded extends PrayerState {
  final String locationName;
  final String hijriDate;
  final List<Map<String, dynamic>> prayers;
  final String currentOrNextPrayerTitle;
  final DateTime? nextPrayerDateTime;
  final bool showPermissionDialog;

  const PrayerLoaded({
    required this.locationName,
    required this.hijriDate,
    required this.prayers,
    required this.currentOrNextPrayerTitle,
    this.nextPrayerDateTime,
    this.showPermissionDialog = false,
  });

  @override
  List<Object?> get props => [
    locationName,
    hijriDate,
    prayers,
    currentOrNextPrayerTitle,
    nextPrayerDateTime,
    showPermissionDialog,
  ];
}

final class PrayerError extends PrayerState {
  final String message;

  const PrayerError(this.message);

  @override
  List<Object?> get props => [message];
}
