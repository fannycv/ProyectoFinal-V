import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:tourbuddy/app/models/place_model.dart';
import 'package:tourbuddy/app/view/recurso/recursos_detalle.dart';

class RecursoCard extends StatelessWidget {
  final Place place;
  final bool isFavorite;

  const RecursoCard({
    super.key,
    required this.place,
    this.isFavorite = false,
  });

  _handleRecursoCardTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecursoDetailPage(place: place),
      ),
    );
  }

//remove from favorites
  void removeFromFavorites() async {
    User? user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance
        .collection('favorites')
        .where('user_uid', isEqualTo: user?.uid ?? "no_auth")
        .where('place_id', isEqualTo: place.id)
        .get()
        .then((snapshot) {
      snapshot.docs.first.reference.delete();
    });
  }

  //add place to favorites
  void addToFavorites() async {
    User? user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance.collection('favorites').add({
      'user_uid': user?.uid ?? "no_auth",
      'place_id': place.id,
      'created_at': DateTime.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => _handleRecursoCardTap(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: Image.network(
                place.gallery?.first ?? '',
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    place.name ?? '',
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.amber,
                        size: 16,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .65,
                        child: Text(
                          '${place.department}-${place.province}-${place.district}',
                          style: const TextStyle(fontSize: 14.0),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        '5km',
                        style: TextStyle(fontSize: 14.0, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      const RatingStars(
                        value: 3,
                        starCount: 5,
                        starSize: 16,
                        valueLabelVisibility: false,
                        starColor: Colors.amber,
                        starSpacing: 7,
                        maxValueVisibility: false,
                        animationDuration: Duration(milliseconds: 1000),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.comment,
                        color: Colors.grey,
                        size: 16,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                      ),
                      IconButton(
                        onPressed: () {
                          if (isFavorite) return removeFromFavorites();

                          addToFavorites();
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                        ),
                      ),
                      const Text(
                        'comments',
                        style: TextStyle(fontSize: 14.0, color: Colors.grey),
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
