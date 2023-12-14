import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:tourbuddy/app/models/place_model.dart';
import 'package:tourbuddy/app/view/recurso/recurso_card_view.dart';

class RecursosView extends StatefulWidget {
  const RecursosView({Key? key}) : super(key: key);

  @override
  State<RecursosView> createState() => _RecursosViewState();
}

class _RecursosViewState extends State<RecursosView>
    with AutomaticKeepAliveClientMixin {
  List<String> favoritePlacesIDs = <String>[];

  Location location = Location();

  late LatLng currentLatLng = const LatLng(0, 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadLocation();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder<QuerySnapshot>(
      stream: getPlacesStream(),
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

        return ListView.separated(
          itemCount: snapshot.data!.docs.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10.0),
          itemBuilder: (context, index) {
            DocumentSnapshot document = snapshot.data!.docs[index];

            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;

            Place place = Place.fromJson(id: document.id, json: data);

            return RecursoCard(
              place: place,
              isFavorite: favoritePlacesIDs.contains(place.id),
              currentLatLng: currentLatLng,
            );
          },
        );
      },
    );
  }

  loadLocation() async {
    location.onLocationChanged.listen((LocationData data) {
      if (mounted) {
        currentLatLng = LatLng(data.latitude ?? 0, data.longitude ?? 0);
      }
    });
  }

  Stream<List<Map<String, dynamic>>> getPlacesWithCommentsStream() {
    return FirebaseFirestore.instance
        .collection('places')
        .limit(3)
        .snapshots()
        .asyncMap((placesSnapshot) async {
      List<Map<String, dynamic>> placesWithComments = [];

      for (var placeDoc in placesSnapshot.docs) {
        String placeId = placeDoc.id;

        QuerySnapshot<Map<String, dynamic>> commentsSnapshot =
            await FirebaseFirestore.instance
                .collection('places/$placeId/comments')
                .get();

        int commentCount = commentsSnapshot.size;

        Map<String, dynamic> placeData = placeDoc.data();
        placeData['commentCount'] = commentCount;
        placeData['id'] = placeDoc.id;

        placesWithComments.add(placeData);
      }

      return placesWithComments;
    });
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
