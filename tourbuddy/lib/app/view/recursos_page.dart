import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:tourbuddy/app/view/recursos_detalle.dart';

class CardView extends StatelessWidget {
  const CardView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        RecursoCard(
          title: 'Playa Los Palos',
          description: 'Tacna - Tacna - Tacna',
          distance: 'a 15 km',
          comments: '5 comentarios',
          imageUrl:
              'https://blog.vivaaerobus.com/wp-content/uploads/2019/12/Mejores-Playas-de-Canc%C3%BAn.jpg', // Reemplaza esto con la URL de tu imagen
        ),
      ],
    );
  }
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.network(
            imageUrl,
            height: 200.0,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () => _handleRecursoCardTap(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey),
                      Text(
                        description,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: Text(
                          distance,
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
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
          ),
        ],
      ),
    );
  }
}
