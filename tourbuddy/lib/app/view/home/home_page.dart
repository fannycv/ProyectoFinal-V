import 'package:flutter/material.dart';
import 'package:tourbuddy/app/view/favoritos/favoritos_page.dart';
import 'package:tourbuddy/app/view/home/welcome_page.dart';
import 'package:tourbuddy/app/view/perfil/perfil.dart';
import 'package:tourbuddy/app/view/recomendaciones/recomendaciones_page.dart';
//import 'package:tourbuddy/app/view/recurso/form_recurso.dart';
import 'package:tourbuddy/app/view/recurso/recursos_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

List<String> titles = <String>[
  'RECURSOS',
  'RECOMENDACIONES',
  'MIS FAVORITOS',
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //TextEditingController _searchController = TextEditingController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          controller: _tabController,
          onTap: (value) {},
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
      body: TabBarView(
        controller: _tabController,
        children: const [
          RecursosView(),
          RecomendacionesView(),

          FavoritosView(
            withAppBar: false,
          )
          // RutasView(),
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.card_travel),
              title: const Text('Recursos'),
              onTap: () {
                _tabController.animateTo(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.travel_explore),
              title: const Text('Recomendaciones'),
              onTap: () {
                _tabController.animateTo(1);

                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favoritos'),
              onTap: () {
                _tabController.animateTo(2);

                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
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
                if (!mounted) return;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomePage()),
                );
              },
            ),
          ],
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
