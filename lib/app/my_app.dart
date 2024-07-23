import 'package:flutter/material.dart';
import 'package:teste/app/pages/zoom_cube.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const ZoomCube(),
    );
  }
}