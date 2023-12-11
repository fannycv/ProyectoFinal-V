import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourbuddy/app/providers/activities_provider.dart';
import 'package:tourbuddy/app/view/welcome.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color.fromRGBO(63, 81, 181, 1);
    const textColor = Color(0xFF4A4A4A);
    const backgroundColor = Color(0xFFF5F5F5);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ActivityProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primary),
          scaffoldBackgroundColor: backgroundColor,
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: 'Poppins',
                bodyColor: textColor,
                displayColor: textColor,
              ),
          useMaterial3: true,
        ),
        home: SplashPage(),
      ),
    );
  }
}
