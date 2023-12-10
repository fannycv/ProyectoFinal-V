import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:tourbuddy/app/view/ruta/rutas_detalle.dart';

class RutasView extends StatelessWidget {
  const RutasView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RutasDetallePage()),
              );
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                'https://cdn.pixabay.com/photo/2019/11/30/12/10/girl-4663125_1280.jpg',
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ruta 1',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.red),
                                  ),
                                  Text(
                                    'Puno',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                print('Compartir');
                              },
                              icon: Icon(Icons.share),
                              color: Colors.amber,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 200,
                          color: Colors.purple.shade300,
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: -12,
                                left: 0,
                                right: 0,
                                child: Card(
                                  elevation: 8.0,
                                  margin: EdgeInsets.all(16.0),
                                  child: Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '8 Recursos - 65 km',
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Descripción de la ruta Descripción de la rutaDescripción de la rutaDescripción de la ruta',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CounterIconButton(
                                  icon: Icons.favorite,
                                  counter: 20,
                                  onPressed: () {
                                    // Lógica para manejar el clic en el contador de favoritos
                                  },
                                ),
                                CounterIconButton(
                                  icon: Icons.comment,
                                  counter: 10,
                                  onPressed: () {
                                    // Lógica para manejar el clic en el contador de comentarios
                                  },
                                ),
                                CounterIconButton(
                                  icon: Icons.star,
                                  counter: 30,
                                  onPressed: () {
                                    // Lógica para manejar el clic en el contador de estrellas
                                  },
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Tooltip(
                                  message: 'Experiencia',
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.camera_alt),
                                      color: Colors.white,
                                      onPressed: () {
                                        // Agregar lógica para tomar o cargar fotos
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CounterIconButton extends StatelessWidget {
  final IconData icon;
  final int counter;
  final VoidCallback? onPressed;

  const CounterIconButton({
    Key? key,
    required this.icon,
    required this.counter,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: badges.Badge(
        badgeContent: Text(
          counter.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 8,
          ),
        ),
        child: Icon(
          icon,
          size: 24,
        ),
        position: badges.BadgePosition.topEnd(
          top: -14,
          end: -10,
        ),
      ),
    );
  }
}
