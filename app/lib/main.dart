import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/splash_screen.dart';
import 'screens/job_listing_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  if (kDebugMode) {
    print('Aplicativo iniciado em modo de desenvolvimento');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
      routes: {
        '/job_listing': (context) => const JobListingScreen(),
      },
      debugShowCheckedModeBanner: true, // Mostra a faixa de debug
    );
  }
}
