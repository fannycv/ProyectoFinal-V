import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:tourbuddy/app/models/activity_model.dart';
import 'package:tourbuddy/app/models/comment_model.dart';
import 'package:tourbuddy/app/models/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:tourbuddy/app/providers/activities_provider.dart';

class RecursoDetailPage extends StatefulWidget {
  final Place place;

  const RecursoDetailPage({super.key, required this.place});

  @override
  State<RecursoDetailPage> createState() => _RecursoDetailPageState();
}

class _RecursoDetailPageState extends State<RecursoDetailPage> {
  CameraPosition? _kGooglePlex;
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  LatLng placeLatLng = const LatLng(0, 0);

  bool loading = true;

  int commentCount = 0;

  void loadResourceLocation() async {
    setState(() {
      _kGooglePlex = CameraPosition(
        target: LatLng(widget.place.location?.latitude ?? 0,
            widget.place.location?.longitude ?? 0),
        zoom: 12.5,
      );

      placeLatLng = LatLng(
        widget.place.location?.latitude ?? 0,
        widget.place.location?.longitude ?? 0,
      );
      loading = false;
    });
  }

  String? currentImage;
  @override
  void initState() {
    super.initState();

    currentImage = widget.place.gallery?.first;
    loadResourceLocation();
    fetchCommentCount();
  }

  Future<void> fetchCommentCount() async {
    QuerySnapshot<Map<String, dynamic>> commentsSnapshot =
        await FirebaseFirestore.instance
            .collection('places')
            .doc(widget.place.id)
            .collection('comments')
            .get();

    setState(() {
      commentCount = commentsSnapshot.size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.place.name!),
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: ListView(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network(
                    currentImage ?? '',
                    height: 200.0,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                          child: GridView.builder(
                            itemCount: widget.place.gallery?.length ?? 0,
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 4.0,
                            ),
                            itemBuilder: (context, index) {
                              String url = widget.place.gallery![index];
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    currentImage = url;
                                  });
                                },
                                borderRadius: BorderRadius.circular(5.0),
                                child: Container(
                                  margin: const EdgeInsets.all(2),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: Image.network(
                                      url,
                                      fit: BoxFit.cover,
                                      width: 100.0,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: <Widget>[
                            const RatingStars(
                              value: 3,
                              starCount: 5,
                              starSize: 15,
                              valueLabelVisibility: true,
                              starColor: Colors.amber,
                              starSpacing: 5,
                              maxValueVisibility: false,
                              animationDuration: Duration(milliseconds: 1000),
                            ),
                            const Spacer(),
                            Text(
                              '$commentCount comentarios',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(children: <Widget>[
                      Text(
                        widget.place.name ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          widget.place.description ?? '',
                        ),
                      ),
                      const SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          height: 200,
                          color: Colors.purple.shade300,
                          child: Stack(
                            children: [
                              if (!loading) mapWidget(),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Card(
                                  elevation: 8.0,
                                  margin: const EdgeInsets.all(16.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(children: [
                                          const Icon(
                                            Icons.location_on,
                                            color: Colors.amber,
                                            size: 16,
                                          ),
                                          Text(
                                            '${widget.place.department}-${widget.place.province}-${widget.place.district}',
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Card(
                        color: Colors.red[100],
                        elevation: 0.0,
                        margin: const EdgeInsets.all(0.0),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'Califica este lugar',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              RatingBar(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      activity(),
                    ]),
                  ),
                  comment(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget activity() {
    return Consumer<ActivityProvider>(
      builder: (context, activityProvider, child) => Column(
        children: [
          const Text(
            'Actividades',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.place.activities?.length ?? 0,
            itemBuilder: (context, index) {
              int? code = widget.place.activities?[index];
              Activity? activity = activityProvider.activities.firstWhere(
                (element) => element.activityCode == code,
                orElse: () => Activity(),
              );

              return ActivityItem(activity: activity);
            },
          ),
          const SizedBox(height: 35),
        ],
      ),
    );
  }

  Widget mapWidget() {
    return SizedBox(
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: GoogleMap(
          indoorViewEnabled: true,
          initialCameraPosition: _kGooglePlex!,
          liteModeEnabled: false,
          myLocationButtonEnabled: false,
          myLocationEnabled: false,
          zoomControlsEnabled: false,
          zoomGesturesEnabled: true,
          scrollGesturesEnabled: true,
          compassEnabled: true,
          rotateGesturesEnabled: true,
          mapToolbarEnabled: true,
          tiltGesturesEnabled: true,
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            Factory<OneSequenceGestureRecognizer>(
              () => EagerGestureRecognizer(),
            ),
          },
          // onTap: (argument) {
          //   setState(() {
          //     latLng =
          //         LatLng(argument.latitude, argument.longitude);
          //   });
          // },
          onMapCreated: (controller) {
            controller = controller;
          },
          markers: {
            Marker(
              draggable: false,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen,
              ),
              markerId: const MarkerId('Localización'),
              position: placeLatLng,
              flat: true,
              onDragStart: null,
              infoWindow: InfoWindow(
                title: widget.place.name,
                snippet: widget.place.district,
              ),
            ),
          },
        ),
      ),
    );
  }

// add comments collection into place collection

  Future<void> addComment(String comment) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) return;

    await FirebaseFirestore.instance
        .collection('places')
        .doc(widget.place.id ?? '')
        .collection('comments')
        .add({
      'comment': comment,
      'created_at': DateTime.now(),
      'user': {
        'uid': currentUser.uid,
        'name': currentUser.displayName,
        'email': currentUser.email,
        'photo_url': currentUser.photoURL,
      }
    });
  }

  TextEditingController commentController = TextEditingController();

  Widget comment() {
    final Stream<QuerySnapshot> commentsStream = FirebaseFirestore.instance
        .collection('places')
        .doc(widget.place.id)
        .collection('comments')
        .orderBy('created_at', descending: true)
        .snapshots();

    return Column(
      children: [
        const SizedBox(height: 10),
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Text(
                  '¿Qué opinas?',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: commentController,
                  maxLength: 200,
                  decoration: const InputDecoration(
                    labelText: 'Escribe un comentario',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (commentController.text.isEmpty) return;

                      addComment(commentController.text);

                      commentController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red.shade100,
                    ),
                    child: const Text(
                      'ENVIAR',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 35),
        const Text(
          'Comentarios',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        const SizedBox(height: 20),
        StreamBuilder<QuerySnapshot>(
          stream: commentsStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 10.0),
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];

                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;

                Comment comment = Comment.fromJson(id: document.id, json: data);

                return Card(
                  color: Colors.white,
                  elevation: 0,
                  margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          leading: comment.user?.photoUrl?.isNotEmpty ?? false
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    comment.user?.photoUrl ?? '',
                                  ),
                                )
                              : const CircleAvatar(
                                  child: Icon(Icons.person_2_outlined),
                                ),
                          title:
                              Text(comment.user?.name ?? 'Usuario desconocido'),
                          subtitle: const RatingStars(
                            value: 5,
                            starCount: 5,
                            starSize: 14,
                            valueLabelVisibility: false,
                            starColor: Colors.amber,
                            starSpacing: 7,
                            maxValueVisibility: false,
                            animationDuration: Duration(
                              milliseconds: 1000,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(comment.comment ?? ''),
                        ),
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.favorite),
                              color: Colors.red,
                              onPressed: () {
                                // Lógica para manejar la acción de "Me encanta"
                              },
                            ),
                            const Text(
                              '5 ',
                              style: TextStyle(color: Colors.grey),
                            ),
                            const Spacer(),
                            Text(
                              timeago.format(
                                comment.createdAt?.toDate() ?? DateTime.now(),
                                locale: 'es',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}

class ActivityItem extends StatelessWidget {
  final Activity activity;

  const ActivityItem({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: ListTile(
          title: Text(activity.activityType ?? ''),
          subtitle: Text(activity.activity ?? ''),
          leading: Icon(activity.getIcon())),
    );
  }
}

class RatingBar extends StatefulWidget {
  const RatingBar({super.key});

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            _rating > index
                ? Icons.star
                : _rating == index
                    ? Icons.star_half
                    : Icons.star_border,
            color: Colors.red,
          ),
          onPressed: () {
            setState(() {
              _rating = index + 1;
            });
          },
        );
      }),
    );
  }
}
