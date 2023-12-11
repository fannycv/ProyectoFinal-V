import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:tourbuddy/app/models/place_model.dart';
import 'package:tourbuddy/app/view/recurso/recursos_detalle.dart';

class CardView extends StatefulWidget {
  const CardView({Key? key}) : super(key: key);

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: placesStream,
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
            );
          },
        );
      },
    );
  }

  final Stream<QuerySnapshot> placesStream =
      FirebaseFirestore.instance.collection('places').snapshots();
}

class RecursoCard extends StatelessWidget {
  final Place place;

  const RecursoCard({
    super.key,
    required this.place,
  });

  _handleRecursoCardTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecursoDetailPage(place: place),
      ),
    );
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
                  const Row(
                    children: <Widget>[
                      RatingStars(
                        value: 3,
                        starCount: 5,
                        starSize: 16,
                        valueLabelVisibility: false,
                        starColor: Colors.amber,
                        starSpacing: 7,
                        maxValueVisibility: false,
                        animationDuration: Duration(milliseconds: 1000),
                      ),
                      Spacer(),
                      Icon(
                        Icons.comment,
                        color: Colors.grey,
                        size: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                      ),
                      Text(
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
