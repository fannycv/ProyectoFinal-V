import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class PerfilView extends StatelessWidget {
  const PerfilView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Lógica cuando se presiona el icono
              print('Icono presionado');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.transparent,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 120,
                      backgroundImage: NetworkImage(
                        'https://i.pinimg.com/474x/23/4b/9e/234b9ee3d4e06c991c5f1b18fdc20bde.jpg',
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'K Julie Clayton',
                      style: TextStyle(
                          fontSize: 28, fontWeight: FontWeight.normal),
                    ),
                    Text(
                      'EE.UU - Texas',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              '15',
                              style: TextStyle(fontSize: 24),
                            ),
                            Text(
                              'Comentarios',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              '120',
                              style: TextStyle(fontSize: 24),
                            ),
                            Text(
                              'Seguidores',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              '120',
                              style: TextStyle(fontSize: 24),
                            ),
                            Text(
                              'Siguiendo',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ImageCard(),
                  ImageCard(),
                  ImageCard(),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'MIS RUTAS',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Segunda galería de imágenes deslizantes con calificación en estrellas
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  RatedImageCard(),
                  RatedImageCard(),
                  RatedImageCard(),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'MIS CALIFICACIONES',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'MIS ACTIVIDADES RECIENTES',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ),

            Card(
              color: Colors.transparent,
              elevation: 0,
              child: ListTile(
                title: Text('Actividad 1'),
              ),
            ),
            Card(
              color: Colors.transparent,
              elevation: 0,
              child: ListTile(
                title: Text('Actividad 2'),
              ),
            ),
            Card(
              color: Colors.transparent,
              elevation: 0,
              child: ListTile(
                title: Text('Actividad 3'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget para las tarjetas de imagen en la galería
class ImageCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Image.network(
        'https://via.placeholder.com/150',
        fit: BoxFit.cover,
      ),
    );
  }
}

// Widget para las tarjetas de imagen con calificación en estrellas en la galería
class RatedImageCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://via.placeholder.com/150',
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8),
          Row(
            children: <Widget>[
              RatingStars(
                value: 3.7,
                starCount: 5,
                starSize: 16,
                valueLabelVisibility: false,
                starColor: Colors.amber,
                starSpacing: 7,
                maxValueVisibility: false,
                animationDuration: Duration(milliseconds: 1000),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
