import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class RecomedacionesView extends StatelessWidget {
  const RecomedacionesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        child: Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return Image.network(
                              "https://images.unsplash.com/photo-1676444299854-03047f5e9ebc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMXx8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=60",
                              height: 100,
                              fit: BoxFit.cover,
                            );
                          },
                          itemCount: 3,
                          pagination: const SwiperPagination(),
                          control: const SwiperControl(),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Playa los Palos',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on, color: Colors.grey),
                                Text(
                                  'Tacna-Tacna',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50.0),
                                  child: Text(
                                    'a 15 km',
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                RatingStars(
                                  value: 4,
                                  starCount: 5,
                                  starSize: 20,
                                  valueLabelVisibility: false,
                                  starColor: Colors.yellow,
                                  starSpacing: 2,
                                  maxValueVisibility: false,
                                  animationDuration:
                                      Duration(milliseconds: 1000),
                                ),
                                SizedBox(width: 5.0),
                                Icon(Icons.comment, color: Colors.grey),
                                Text(
                                  ' 6 comentarios',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
