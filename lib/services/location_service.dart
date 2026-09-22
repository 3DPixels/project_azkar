import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'cache_service.dart';

class LocationService {
  /// Returns cached location immediately if present using CacheService
  Future<Map<String, dynamic>?> getCachedLocation() async {
    return CacheService.getCachedLocation();
  }

  /// Requests permissions and gets current location from GPS
  Future<Map<String, dynamic>> fetchFreshLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw Exception('Location services are disabled.');

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    // UPDATE 1: Geolocator now uses LocationSettings instead of desiredAccuracy
    final locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.low,
    );

    final position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );

    String cityFormatted = 'القاهرة، مصر';
    try {
      // UPDATE 2: Geocoding methods are now called on a Geocoding instance
      final Geocoding geocoding = Geocoding();

      List<Placemark> placemarks = await geocoding.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        cityFormatted =
            '${place.locality ?? place.subAdministrativeArea}، ${place.country}';
      }
    } catch (_) {
      // Fallback to the default if reverse geocoding fails
    }

    // Cache results using your CacheService
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
