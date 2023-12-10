import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:tourbuddy/app/view/restaurante/restaurante_detalle.dart';

class RestauranteView extends StatelessWidget {
  const RestauranteView({
    Key? key,
  }) : super(key: key);

  _handleRecursoCardTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RestauranteDetailPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
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
                  'https://www.revistainteriores.es/uploads/s1/23/67/55/5/los-25-restaurantes-con-mejor-diseno-de-barcelona.jpeg',
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
                      'Restaurante 1',
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
                          '5 comentarios',
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
      ),
    );
  }
}
