import 'package:flutter/material.dart';
import 'package:tourbuddy/app/view/favoritos/favoritos_page.dart';
import 'package:tourbuddy/app/view/home/welcome_page.dart';
import 'package:tourbuddy/app/view/perfil/perfil.dart';
import 'package:tourbuddy/app/view/recomendaciones/recomendaciones_page.dart';
//import 'package:tourbuddy/app/view/recurso/form_recurso.dart';
import 'package:tourbuddy/app/view/recurso/recursos_page.dart';
import 'package:tourbuddy/app/view/ruta/rutas_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

List<String> titles = <String>[
  'RECURSOS',
  'RECOMENDACIONES',
  'RUTAS',
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int counter = 0;
  int initialIndex = 0;

  //TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: initialIndex,
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.indigo,
          iconTheme: const IconThemeData(color: Colors.white),

          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PerfilView()),
                );
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1515621061946-eff1c2a352bd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1089&q=80'),
                ),
              ),
            ),
          ],
          //aqui boton de busqueda
          bottom: TabBar(
            onTap: (value) {
              setState(() {
                initialIndex = value;
              });
            },
            tabs: <Widget>[
              Tab(
                text: titles[0],
              ),
              Tab(
                text: titles[1],
              ),
              Tab(
                text: titles[2],
              ),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
          ),
        ),
        /*
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            switch (initialIndex) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RecursoFormView()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ExperienciaView()),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RutaFormView()),
                );
                break;
              default:
            }
          },
          child: const Icon(Icons.add),
        ),
        */
        body: const TabBarView(
          children: [
            RecursosView(),
            RecomendacionesView(),
            RutasView(),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.indigo,

                  /* image: DecorationImage(
                        image: AssetImage('assets/images/estilo.png'),
                        fit: BoxFit.cover)*/
                ),
                child: Text(
                  'TourBuddy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  setState(() {
                    initialIndex = 0;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.card_travel),
                title: const Text('Recursos'),
                onTap: () {
                  setState(() {
                    initialIndex = 1;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.travel_explore),
                title: const Text('Recomendaciones'),
                onTap: () {
                  setState(() {
                    initialIndex = 2;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.route),
                title: const Text('Rutas'),
                onTap: () {
                  setState(() {
                    initialIndex = 3;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('Favoritos'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavoritosView()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text('Perfil'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const PerfilView()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Cerrar Sesion'),
                onTap: () async {
                  await _signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomePage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _signOut() async {
  try {
    await AuthenticationService().signOut();
  } catch (e) {
    print("Error al cerrar sesión: $e");
  }
}

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
