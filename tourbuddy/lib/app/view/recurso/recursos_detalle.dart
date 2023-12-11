import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tourbuddy/app/models/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

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

  // late final Location location = Location();

  bool loading = true;

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

  @override
  void initState() {
    super.initState();

    loadResourceLocation();
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
                    'https://elcomercio.pe/resizer/PF8csebjB4fMHSZZaHNVan_6_ZE=/980x0/smart/filters:format(jpeg):quality(75)/arc-anglerfish-arc2-prod-elcomercio.s3.amazonaws.com/public/6WIO3UTLZNGLXAOHHLNSG74PHQ.jpg',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 4.0,
                            ),
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(2),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Image.network(
                                    'https://cdn.vuetifyjs.com/images/cards/sunshine.jpg',
                                    fit: BoxFit.cover,
                                    width: 100.0,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          children: <Widget>[
                            RatingStars(
                              value: 3,
                              starCount: 5,
                              starSize: 15,
                              valueLabelVisibility: true,
                              starColor: Colors.amber,
                              starSpacing: 5,
                              maxValueVisibility: false,
                              animationDuration: Duration(milliseconds: 1000),
                            ),
                            Spacer(),
                            Text(
                              '10 comentarios',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
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
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(15),
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
                                maxLength: 200,
                                decoration: const InputDecoration(
                                  labelText: 'Escribe un comentario',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  print(
                                      'Number of characters: ${value.length}');
                                },
                              ),
                              const SizedBox(height: 20),
                              Align(
                                alignment: Alignment.topRight,
                                child: ElevatedButton(
                                  onPressed: () {},
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
                        'Actividades',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: const [
                          ActivityItem(
                            title: 'Actividad 1',
                            name: 'Nombre 1',
                          ),
                          ActivityItem(
                            title: 'Actividad 2',
                            name: 'Nombre 2',
                          ),
                          ActivityItem(
                            title: 'Actividad 3',
                            name: 'Nombre 3',
                          ),
                        ],
                      ),
                      const SizedBox(height: 35),
                      const Text(
                        'Comentarios',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Card(
                        color: Colors.white,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://i.pinimg.com/474x/3e/2e/47/3e2e4748da61c30e6c43a7877874ef1c.jpg'),
                                ),
                                title: Text('Katy Tucker'),
                                subtitle: RatingStars(
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
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                    'Love this spot! I was there with my fiance and a dog once and it\'s the best place to spend time not that far from the city.'),
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
                                  const Text('Hace 6 días'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
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
}

class ActivityItem extends StatelessWidget {
  final String title;
  final String name;

  const ActivityItem({
    super.key,
    required this.title,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: ListTile(
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: $name'),
          ],
        ),
      ),
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
