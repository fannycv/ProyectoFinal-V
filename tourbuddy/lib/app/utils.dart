import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Util {
  // Calcula la distancia entre dos puntos utilizando la fórmula de Haversine
  static double calculateDistance({
    required LatLng firstPoint,
    required LatLng secondPoint,
    bool inMeters = false,
  }) {
    const int earthRadius = 6371; // Radio de la Tierra en kilómetros

    // Convertir grados a radianes
    double startLatRadians = degreesToRadians(firstPoint.latitude);
    double endLatRadians = degreesToRadians(secondPoint.latitude);

    double latDiffRadians =
        degreesToRadians(secondPoint.latitude - firstPoint.latitude);
    double lonDiffRadians =
        degreesToRadians(secondPoint.longitude - firstPoint.longitude);

    // Fórmula de Haversine
    double a = sin(latDiffRadians / 2) * sin(latDiffRadians / 2) +
        cos(startLatRadians) *
            cos(endLatRadians) *
            sin(lonDiffRadians / 2) *
            sin(lonDiffRadians / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Distancia en kilómetros
    double distance = earthRadius * c;

    if (inMeters) return distance *= 1000;

    return distance;
  }

  static double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }
}
