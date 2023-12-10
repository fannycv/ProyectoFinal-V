import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class ExperienciaView extends StatelessWidget {
  const ExperienciaView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Experiencias'),
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1577565177023-d0f29c354b69?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OTh8fHByb2ZpbGV8ZW58MHx8MHx8fDA%3D', // URL de tu avatar
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Experiencia 1',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Peru',
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
                            // Lógica para manejar el clic en el ícono de compartir
                            print('Compartir');
                          },
                          icon: Icon(Icons.share),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.network(
                              'https://elcomercio.pe/resizer/TsU1PT3iZ6XQnysaygWwz9acEZw=/1200x1200/smart/filters:format(jpeg):quality(75)/cloudfront-us-east-1.images.arcpublishing.com/elcomercio/4QNBZB6RLRFLBCKWXBH2SAP2W4.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.network(
                              'https://elcomercio.pe/resizer/TsU1PT3iZ6XQnysaygWwz9acEZw=/1200x1200/smart/filters:format(jpeg):quality(75)/cloudfront-us-east-1.images.arcpublishing.com/elcomercio/4QNBZB6RLRFLBCKWXBH2SAP2W4.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //height: 150,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.network(
                              'https://elcomercio.pe/resizer/TsU1PT3iZ6XQnysaygWwz9acEZw=/1200x1200/smart/filters:format(jpeg):quality(75)/cloudfront-us-east-1.images.arcpublishing.com/elcomercio/4QNBZB6RLRFLBCKWXBH2SAP2W4.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.network(
                              'https://elcomercio.pe/resizer/TsU1PT3iZ6XQnysaygWwz9acEZw=/1200x1200/smart/filters:format(jpeg):quality(75)/cloudfront-us-east-1.images.arcpublishing.com/elcomercio/4QNBZB6RLRFLBCKWXBH2SAP2W4.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.network(
                              'https://elcomercio.pe/resizer/TsU1PT3iZ6XQnysaygWwz9acEZw=/1200x1200/smart/filters:format(jpeg):quality(75)/cloudfront-us-east-1.images.arcpublishing.com/elcomercio/4QNBZB6RLRFLBCKWXBH2SAP2W4.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ac ullamcorper justo.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.grey.shade200,
                    child: Row(
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
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            print('Ver más');
                          },
                          child: Text(
                            'VER',
                            style: TextStyle(
                              color: Colors.blue, // Cambia el color del texto
                            ),
                          ),
                        )
                      ],
                    ),
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
