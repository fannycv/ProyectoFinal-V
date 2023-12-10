import 'package:flutter/material.dart';
import 'package:tourbuddy/app/view/hotel/hotel_page.dart';
import 'package:tourbuddy/app/view/restaurante/restaurante_page.dart';
import 'package:tourbuddy/app/view/ruta/route_detail.dart';

class RutasDetallePage extends StatefulWidget {
  @override
  State<RutasDetallePage> createState() => _RutasDetallePageState();
}

class _RutasDetallePageState extends State<RutasDetallePage> {
  int initialIndex = 0;
  late String currentTitle;
  final List<Tab> tabs = [
    Tab(icon: Icon(Icons.map)),
    Tab(icon: Icon(Icons.restaurant)),
    Tab(icon: Icon(Icons.hotel)),
  ];

  @override
  void initState() {
    super.initState();
    currentTitle = 'Ruta';
  }

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
          title: Text(
            currentTitle,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          bottom: TabBar(
            onTap: (value) {
              setState(() {
                initialIndex = value;
                switch (initialIndex) {
                  case 0:
                    currentTitle = 'Ruta 1';
                    break;
                  case 1:
                    currentTitle = 'Restaurantes';
                    break;
                  case 2:
                    currentTitle = 'Alojamientos';
                    break;
                }
              });
            },
            tabs: tabs,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            switch (initialIndex) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RouteDetail()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RestauranteView()),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HotelView()),
                );
                break;
              default:
            }
          },
          child: const Icon(Icons.add),
        ),
        body: TabBarView(
          children: [
            RouteDetail(),
            RestauranteView(),
            HotelView(),
          ],
        ),
      ),
    );
  }
}
