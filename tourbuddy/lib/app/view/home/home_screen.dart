import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tourbuddy/app/view/home/home_page.dart';
import 'package:tourbuddy/app/view/autentificacion/login_screen.dart';

class CarouselPage extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String description;

  CarouselPage({
    required this.imageAsset,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/image.png',
            width: 151,
            height: 138,
          ),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              'TourBuddy',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 60),
          Center(
            child: Image.asset(
              imageAsset,
              width: 180,
              height: 168,
            ),
          ),
          const SizedBox(height: 9),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 21),
                Text(
                  description,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 80),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      //para ir a la pantalla principal
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: const Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.indigo,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height,
          enableInfiniteScroll: false,
          viewportFraction: 1.0,
          aspectRatio: 16 / 9,
          onPageChanged: (index, reason) {},
        ),
        items: [
          CarouselPage(
            imageAsset: 'assets/images/travel.png',
            title: 'Tus preferencias',
            description:
                'Opten recomendaciones que se ajusten a tus preferencias y recursos que dispones',
          ),
          CarouselPage(
            imageAsset: 'assets/images/travel.png',
            title: 'Tus rutas',
            description: 'Crea tu ruta  base a las recomendaciones obtenidas',
          ),
          CarouselPage(
            imageAsset: 'assets/images/travel.png',
            title: 'Alta personalización',
            description:
                'Agrega y quita recursos para construir una ruta mas Personalizada',
          ),
          CarouselPage(
            imageAsset: 'assets/images/travel.png',
            title: 'Comparte',
            description:
                'Haz que se enteren otros usuario o amigos de tus experiencias vividas',
          ),
          CarouselPage(
            imageAsset: 'assets/images/travel.png',
            title: 'Una guia',
            description:
                'Consulta los servicios y Mantente informado de todo De los recursos durante el viaje',
          ),
        ],
      ),
    );
  }
}
