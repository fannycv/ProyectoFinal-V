import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:tourbuddy/app/view/rutas_detalle.dart';

class RutasView extends StatelessWidget {
  const RutasView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RutaDetallePage()),
        );
      },
      child: Card(
        margin: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1515621061946-eff1c2a352bd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1089&q=80'),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  const Expanded(
                    child: Text(
                      'Nombre de la ruta',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      // Agregar lógica para compartir
                    },
                  ),
                ],
              ),
            ),
            // Mapa con card pequeño
            Container(
              height: 200.0, // Ajustar la altura según sea necesario
              color: Colors.grey, // Reemplazar con el widget del mapa
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '8 recursos',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Descripción
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Descripción de la ruta',
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
                        icon: Icons.comment,
                        counter: 10,
                        onPressed: () {
                          // Lógica para manejar el clic en el contador de comentarios
                        },
                      ),
                      CounterIconButton(
                        icon: Icons.favorite,
                        counter: 20,
                        onPressed: () {
                          // Lógica para manejar el clic en el contador de favoritos
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Tooltip(
                      message: 'Experiencia',
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {
                          // Agregar lógica para tomar o cargar fotos
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
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
          style: TextStyle(color: Colors.white),
        ),
        child: Icon(icon),
        position: badges.BadgePosition.topEnd(
            top: -8,
            end: -8), // Posiciona el badge en la esquina superior derecha
        // Cambia el color de fondo del badge solo si el contador es mayor que 0
      ),
    );
  }
}
