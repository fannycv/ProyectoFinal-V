import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class HotelDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alojamiento 1'),
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
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
                    'https://cf.bstatic.com/xdata/images/hotel/max1024x768/414550177.jpg?k=8eb33b9f0f1edf8dee5a5d892c828e0a8f469c5f7a5a89c3d786751aba05cf67&o=&hp=1',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 4.0,
                            ),
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(2),
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
                        Row(
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
                            const Spacer(),
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
                        'Alojamiento 1',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Son playas abiertas de bajo oleaje, en cuyas orillas se tiene la presencia de arena fina...',
                        ),
                      ),
                      SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          height: 200,
                          color: Colors.purple.shade300,
                          child: Stack(
                            children: [
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
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.amber,
                                            size: 16,
                                          ),
                                          Text(
                                            'Tacna - Tacna - Tacna',
                                            style: TextStyle(
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
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Text(
                                  'Califica este lugar',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
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
                                decoration: InputDecoration(
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
                        physics: NeverScrollableScrollPhysics(),
                        children: [
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
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ListTile(
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
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                    'Love this spot! I was there with my fiance and a dog once and it\'s the best place to spend time not that far from the city.'),
                              ),
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.favorite),
                                    color: Colors.red,
                                    onPressed: () {
                                      // Lógica para manejar la acción de "Me encanta"
                                    },
                                  ),
                                  Text(
                                    '5 ',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  const Spacer(),
                                  Text('Hace 6 días'),
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
}

class ActivityItem extends StatelessWidget {
  final String title;
  final String name;

  const ActivityItem({
    required this.title,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
