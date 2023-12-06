import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:tourbuddy/app/models/place_model.dart';
import 'package:tourbuddy/app/view/recursos_detalle.dart';

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
              title: place.name ?? '',
              description:
                  '${place.department} - ${place.province} - ${place.district}',
              distance: 'a 15 km',
              comments: '5 comentarios',
              imageUrl: place.gallery?.first ?? '',
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
  final String title;
  final String description;
  final String distance;
  final String comments;
  final String imageUrl;

  RecursoCard({
    this.title = '',
    this.description = '',
    this.distance = '',
    this.comments = '',
    this.imageUrl = '',
  });

  _handleRecursoCardTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecursoDetailPage(title: title),
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
                imageUrl,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.grey),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .65,
                        child: Text(
                          description,
                          style: const TextStyle(fontSize: 14.0),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        distance,
                        style:
                            const TextStyle(fontSize: 14.0, color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      RatingStars(
                        value: 3,
                        starCount: 5,
                        starSize: 20,
                        valueLabelVisibility: false,
                        starColor: Colors.yellow,
                        starSpacing: 2,
                        maxValueVisibility: false,
                        animationDuration: Duration(milliseconds: 1000),
                      ),
                      SizedBox(width: 5.0),
                      Icon(Icons.comment, color: Colors.grey),
                      Text(
                        comments,
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
