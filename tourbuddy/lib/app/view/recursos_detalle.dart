import 'package:flutter/material.dart';

class RecursoDetailPage extends StatelessWidget {
  final String title;

  RecursoDetailPage({this.title = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Detalles de la playa'),
      ),
    );
  }
}
