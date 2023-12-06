import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tourbuddy/app/view/home_page.dart';
import 'package:tourbuddy/app/view/login_screen.dart';

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
            imageAsset,
            width: 141,
            height: 129,
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
              'assets/images/estilo.png',
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
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF40B7AD),
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
                      color: Colors.blue,
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
            imageAsset: 'assets/images/Vector.png',
            title: 'Tus preferencias',
            description:
                'Opten recomendaciones que se ajusten a tus preferencias y recursos que dispones',
          ),
          CarouselPage(
            imageAsset: 'assets/images/Vector.png',
            title: 'Tus rutas',
            description: 'Crea tu ruta  base a las recomendaciones obtenidas',
          ),
          CarouselPage(
            imageAsset: 'assets/images/Vector.png',
            title: 'Alta personalización',
            description:
                'Agrega y quita recursos para construir una ruta mas Personalizada',
          ),
          CarouselPage(
            imageAsset: 'assets/images/Vector.png',
            title: 'Comparte',
            description:
                'Haz que se enteren otros usuario o amigos de tus experiencias vividas',
          ),
          CarouselPage(
            imageAsset: 'assets/images/Vector.png',
            title: 'Una guia',
            description:
                'Consulta los servicios y Mantente informado de todo De los recursos durante el viaje',
          ),
        ],
      ),
    );
  }
}
