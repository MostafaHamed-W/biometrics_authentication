import 'package:biometrics_authentication/home/home_screen.dart';
import 'package:flutter/material.dart';

class BiometricsAuthentication extends StatelessWidget {
  const BiometricsAuthentication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biometrics Authentication Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
