import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:tourbuddy/app/view/recomendaciones/recomendaciones_detalle.dart';

class RecomedacionesView extends StatelessWidget {
  const RecomedacionesView({
    Key? key,
  }) : super(key: key);

  _handleRecursoCardTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecomendacionesDetailPage(),
      ),
    );
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
                Card(
                  child: InkWell(
                    onTap: () => _handleRecursoCardTap(context),
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
                              "https://images.unsplash.com/photo-1676444299854-03047f5e9ebc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMXx8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=60",
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
                                'Playa los Palos',
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
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
                                      'Tacna-Tacna-Tacna',
                                      style: const TextStyle(fontSize: 14.0),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    'a 15 km',
                                    style: const TextStyle(
                                        fontSize: 14.0, color: Colors.grey),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: <Widget>[
                                  RatingStars(
                                    value: 3,
                                    starCount: 5,
                                    starSize: 16,
                                    valueLabelVisibility: false,
                                    starColor: Colors.amber,
                                    starSpacing: 7,
                                    maxValueVisibility: false,
                                    animationDuration:
                                        Duration(milliseconds: 1000),
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
                                    '6 comentarios',
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
