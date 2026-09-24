import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'cache_service.dart';

enum LocationPermissionResult {
  granted,
  denied,
  permanentlyDenied,
  serviceDisabled,
}

class LocationService {
  /// Check permissions without requesting them yet
  Future<LocationPermissionResult> checkPermissionStatus() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return LocationPermissionResult.serviceDisabled;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      return LocationPermissionResult.denied;
    }
    if (permission == LocationPermission.deniedForever) {
      return LocationPermissionResult.permanentlyDenied;
    }
    return LocationPermissionResult.granted;
  }

  /// Request permissions from OS
  Future<LocationPermissionResult> requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return LocationPermissionResult.denied;
    }
    if (permission == LocationPermission.deniedForever) {
      return LocationPermissionResult.permanentlyDenied;
    }
    return LocationPermissionResult.granted;
  }

  /// Fetch location fast: Cache -> Last Known GPS -> Fresh GPS
  Future<Map<String, dynamic>> fetchLocation() async {
    // 1. Check last known position for instant response
    Position? position = await Geolocator.getLastKnownPosition();

    // 2. Fallback to fresh position if last known is null
    position ??= await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.low),
    );

    String cityFormatted = 'القاهرة، مصر';
    try {
      final geocoding = Geocoding();
      List<Placemark> placemarks = await geocoding.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
        locale: Locale('ar'), // Force Arabic locale for reverse geocoding
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final city =
            place.locality ??
            place.subAdministrativeArea ??
            place.administrativeArea;
        final country = place.country ?? '';
        cityFormatted = city != null && city.isNotEmpty
            ? '$city، $country'
            : country;
      }
    } catch (_) {
      // Fallback city string remains Cairo if geocoding fails
    }

    await CacheService.cacheLocation(
      position.latitude,
      position.longitude,
      cityFormatted,
    );

    return {
      'lat': position.latitude,
      'lng': position.longitude,
      'city': cityFormatted,
    };
  }
}
