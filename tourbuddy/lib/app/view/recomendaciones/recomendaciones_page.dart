import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tourbuddy/app/models/place_model.dart';
import 'dart:math' show sin, pi, cos, sqrt, asin;

class RecomendacionesView extends StatefulWidget {
  const RecomendacionesView({Key? key}) : super(key: key);

  @override
  _RecomendacionesViewState createState() => _RecomendacionesViewState();
}

class _RecomendacionesViewState extends State<RecomendacionesView> {
  late Position _userLocation;

  @override
  void initState() {
    super.initState();
  }

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation() async {
    Position position = await determinePosition();
    // Almacena la ubicación en la variable _userLocation
    setState(() {
      _userLocation = position;
    });
    print("Latitude: ${_userLocation.latitude}");
    print("Longitude: ${_userLocation.longitude}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    getCurrentLocation();
                  },
                  child: Text('Mi ubicacion'),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: getPlacesStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final places = snapshot.data!.docs;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: places.length > 10 ? 10 : places.length,
                        itemBuilder: (context, index) {
                          final placeData =
                              places[index].data() as Map<String, dynamic>;
                          final place = Place.fromJson(
                              id: places[index].id, json: placeData);

                          return RecursoCard(
                            placeName: place.name ?? '',
                            location: placeData['location'] != null
                                ? 'Ubicación disponible'
                                : 'Ubicación no disponible',
                            distance: placeData['distance'] ?? '',
                            rating: placeData['rating'] ?? 0.0,
                            commentCount:
                                (placeData['comments'] as List<dynamic>?)
                                        ?.length ??
                                    0,
                            imageUrl: place.gallery?.first ?? '',

                            department: place.department ??
                                '', // Agregar el departamento del lugar
                            province: place.province ??
                                '', // Agregar la provincia del lugar
                            district: place.district ??
                                '', // Agregar el distrito del lugar
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error al cargar los lugares.');
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stream<QuerySnapshot> getPlacesStream() {
    return FirebaseFirestore.instance
        .collection('places')
        .orderBy(_getOrderByField())
        .limit(15)
        .snapshots();
  }

  String _getOrderByField() {
    // Calcular la distancia desde la ubicación actual del usuario hasta cada lugar
    // y ordenar por esa distancia
    return 'location'; // Reemplazar con el campo correcto para la distancia
  }

  // Método para calcular la distancia entre dos coordenadas geográficas
  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371.0; // Radio de la Tierra en kilómetros

    // Convertir las coordenadas de grados a radianes
    final double lat1Rad = _degreesToRadians(lat1);
    final double lon1Rad = _degreesToRadians(lon1);
    final double lat2Rad = _degreesToRadians(lat2);
    final double lon2Rad = _degreesToRadians(lon2);

    // Calcular la diferencia de latitud y longitud
    final double dLat = lat2Rad - lat1Rad;
    final double dLon = lon2Rad - lon1Rad;

    // Calcular la distancia utilizando la fórmula de Haversine
    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1Rad) * cos(lat2Rad) * sin(dLon / 2) * sin(dLon / 2);
    final double c = 2 * asin(sqrt(a));
    final double distance = earthRadius * c;

    return distance;
  }

  // Método para convertir grados a radianes
  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180.0);
  }
}

class RecursoCard extends StatelessWidget {
  final String placeName;
  final String location;
  final String distance;
  final double rating;
  final int commentCount;
  final String imageUrl;
  final String? department;
  final String? province;
  final String? district;

  const RecursoCard({
    required this.placeName,
    required this.location,
    required this.distance,
    required this.rating,
    required this.commentCount,
    required this.imageUrl,
    required this.department,
    required this.province,
    required this.district,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          // Handle card tap
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: Image.network(
                  imageUrl,
                  height: 200.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    placeName,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.amber,
                        size: 16,
                      ),
                      Flexible(
                        child: Text(
                          '${department}-${province}-${district}',
                          style: const TextStyle(fontSize: 14.0),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        distance,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      RatingStars(
                        value: rating,
                        starCount: 5,
                        starSize: 16,
                        valueLabelVisibility: false,
                        starColor: Colors.amber,
                        starSpacing: 7,
                        maxValueVisibility: false,
                        animationDuration: Duration(milliseconds: 1000),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.comment,
                        color: Colors.grey,
                        size: 16,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                      ),
                      Text(
                        '$commentCount comentarios',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
