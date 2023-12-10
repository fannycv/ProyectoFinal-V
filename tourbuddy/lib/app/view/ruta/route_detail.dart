import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class RouteDetail extends StatelessWidget {
  const RouteDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 300,
                  color: Colors.purple.shade300,
                  child: Stack(
                    children: [
                      // Mapa u otras widgets que no deben desplazarse
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '8 Recursos',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            ' - 65 km',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'The shortest distance I will travel when visiting the & resources',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 35),
                      Text(
                        'Descripción de la ruta Descripción de la rutaDescripción de la rutaDescripción de la ruta',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 20),
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
                                padding: const EdgeInsets.all(3.0),
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
                              Padding(
                                padding: const EdgeInsets.all(3.0),
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
                              Padding(
                                padding: const EdgeInsets.all(3.0),
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
                      const SizedBox(height: 20),
                      const Text(
                        'Experiencias',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(height: 20),
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
                      Container(
                        padding: EdgeInsets.all(8.0),
                        color: Colors.grey.shade200,
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                  color:
                                      Colors.blue, // Cambia el color del texto
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Comentarios',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),

                      // Comentarios estáticos con perfiles
                      CommentTile(
                        comment: Comment(
                          author: 'Usuario1',
                          text: '¡Excelente ruta!',
                          timestamp: DateTime.now(),
                        ),
                        profile: UserProfile(
                          username: 'user1',
                          avatarUrl: 'https://example.com/user1_avatar.jpg',
                        ),
                      ),
                      CommentTile(
                        comment: Comment(
                          author: 'Usuario2',
                          text: 'Me encantó la experiencia.',
                          timestamp: DateTime.now(),
                        ),
                        profile: UserProfile(
                          username: 'user2',
                          avatarUrl: 'https://example.com/user2_avatar.jpg',
                        ),
                      ),
                      CommentTile(
                        comment: Comment(
                          author: 'Usuario3',
                          text: 'Muy buenos recursos.',
                          timestamp: DateTime.now(),
                        ),
                        profile: UserProfile(
                          username: 'user3',
                          avatarUrl: 'https://example.com/user3_avatar.jpg',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserProfile {
  final String username;
  final String avatarUrl;

  UserProfile({
    required this.username,
    required this.avatarUrl,
  });
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

class Comment {
  final String author;
  final String text;
  final DateTime timestamp;

  Comment({
    required this.author,
    required this.text,
    required this.timestamp,
  });
}

class CommentTile extends StatelessWidget {
  final Comment comment;
  final UserProfile profile;

  const CommentTile({
    Key? key,
    required this.comment,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(profile.avatarUrl),
        radius: 16,
      ),
      title: Text(profile.username),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(comment.text),
          Text(comment.timestamp.toString()),
        ],
      ),
    );
  }
}
