import 'package:flutter/material.dart';
import 'package:gemini_test/layout.dart';
import 'package:gemini_test/services/api_services.dart';
import 'package:gemini_test/services/location.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => ApiService()),
        Provider(create: (_) => LocationService()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LayoutScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
