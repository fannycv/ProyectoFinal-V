import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:tourbuddy/app/models/place_model.dart';
// ignore: depend_on_referenced_packages
import 'package:rxdart/rxdart.dart';
import 'package:tourbuddy/app/utils.dart';

import 'package:tourbuddy/app/view/recurso/recurso_card_view.dart';

final GeoFlutterFire geo = GeoFlutterFire();

class RecomendacionesView extends StatefulWidget {
  const RecomendacionesView({Key? key}) : super(key: key);

  @override
  State<RecomendacionesView> createState() => _RecomendacionesViewState();
}

class _RecomendacionesViewState extends State<RecomendacionesView>
    with AutomaticKeepAliveClientMixin {
  List<String> favoritePlacesIDs = <String>[];

  final Location location = Location();

  bool loading = true;

  Stream<List<DocumentSnapshot>>? stream;

  double radius = 10;

  double distance = 0;

  var center = BehaviorSubject<GeoFirePoint>.seeded(
      geo.point(latitude: 0, longitude: 0));

  var places = FirebaseFirestore.instance.collection('places').limit(20);

  late LatLng currentLatLng = const LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    loadLocation();
  }

  loadLocation() async {
    stream = center.switchMap((rad) {
      return geo.collection(collectionRef: places).within(
            center: rad,
            radius: radius,
            field: 'position',
          );
    });

    location.onLocationChanged.listen((LocationData data) {
      // Aquí puedes manejar la nueva ubicación obtenida
      // Puedes actualizar tu Firestore aquí o cualquier otra lógica relacionada con la ubicación

      if (currentLatLng.latitude == 0) {
        if (mounted) {
          setState(() {
            currentLatLng = LatLng(data.latitude ?? 0, data.longitude ?? 0);
          });
        }

        center.add(
            geo.point(latitude: data.latitude!, longitude: data.longitude!));
        return;
      }

      double newDistance = Util.calculateDistance(
        firstPoint: LatLng(data.latitude ?? 0, data.longitude ?? 0),
        secondPoint: currentLatLng,
        inMeters: true,
      );

      if (mounted) {
        setState(() {
          currentLatLng = LatLng(data.latitude ?? 0, data.longitude ?? 0);
        });
      }

      print(["DISTANCE", (distance - newDistance).abs()]);
      if ((distance - newDistance).abs() > 10) {
        print("ACTUALIZAR");
        if (mounted) {
          setState(() {
            distance = newDistance;
          });
        }

        center.add(
            geo.point(latitude: data.latitude!, longitude: data.longitude!));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder<List<DocumentSnapshot<dynamic>>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return SingleChildScrollView(
            child: SkeletonLoader(
              items: 3,
              baseColor: Theme.of(context).colorScheme.background,
              highlightColor: Theme.of(context).colorScheme.surfaceVariant,
              builder: Card(
                child: Column(
                  children: [
                    Container(
                      height: 300,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No hay lugares cercanos'),
          );
        }

        return ListView.separated(
          itemCount: snapshot.data!.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10.0),
          itemBuilder: (context, index) {
            DocumentSnapshot document = snapshot.data![index];

            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;

            Place place = Place.fromJson(id: document.id, json: data);

            return RecursoCard(
              place: place,
              isFavorite: favoritePlacesIDs.contains(place.id),
              currentLatLng: currentLatLng.latitude == 0 ? null : currentLatLng,
            );
          },
        );
      },
    );
  }

  Stream<QuerySnapshot> getPlacesStream() {
    // Obtener el Stream de los IDs de los lugares favoritos

    User? user = FirebaseAuth.instance.currentUser;

    Stream<QuerySnapshot> favoritesStream = FirebaseFirestore.instance
        .collection('favorites')
        .limit(10)
        .where('user_uid', isEqualTo: user?.uid ?? "no_auth")
        .snapshots();

    return favoritesStream.asyncMap((favoritesSnapshot) async {
      List<String> temp = [];

      for (var doc in favoritesSnapshot.docs) {
        temp.add(doc['place_id'] as String);
      }

      favoritePlacesIDs = temp;
      // Obtener los detalles de los lugares favoritos basados en los IDs
      QuerySnapshot placesSnapshot =
          await FirebaseFirestore.instance.collection('places').get();

      return placesSnapshot;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
