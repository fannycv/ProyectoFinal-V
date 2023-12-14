import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourbuddy/app/models/place_model.dart';
import 'package:tourbuddy/app/view/recurso/recurso_card_view.dart';

class FavoritosView extends StatefulWidget {
  const FavoritosView({Key? key}) : super(key: key);

  @override
  State<FavoritosView> createState() => _FavoritosViewState();
}

class _FavoritosViewState extends State<FavoritosView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Favoritos'),
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getFavoritePlacesStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                isFavorite: true,
              );
            },
          );
        },
      ),
    );
  }

  Stream<QuerySnapshot> getFavoritePlacesStream() {
    // Obtener el Stream de los IDs de los lugares favoritos

    User? user = FirebaseAuth.instance.currentUser;

    Stream<QuerySnapshot> favoritesStream = FirebaseFirestore.instance
        .collection('favorites')
        .where('user_uid', isEqualTo: user?.uid ?? "no_auth")
        .snapshots();

    return favoritesStream.asyncMap((favoritesSnapshot) async {
      List<String> favoritePlacesIDs = [];

      for (var doc in favoritesSnapshot.docs) {
        favoritePlacesIDs.add(doc['place_id'] as String);
      }

      if (favoritePlacesIDs.isEmpty) {
        return await FirebaseFirestore.instance
            .collection('places')
            .doc('dummy')
            .collection('dummy')
            .get();
      }

      // Obtener los detalles de los lugares favoritos basados en los IDs
      QuerySnapshot placesSnapshot = await FirebaseFirestore.instance
          .collection('places')
          .where(FieldPath.documentId, whereIn: favoritePlacesIDs)
          .get();

      return placesSnapshot;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
