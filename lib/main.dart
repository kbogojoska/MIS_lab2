import 'package:flutter/material.dart';
import 'screens/joke_types_screen.dart';
import 'screens/jokes_by_type_screen.dart';
import 'screens/random_joke_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke App',
      initialRoute: '/',
      routes: {
        '/': (context) => const JokeTypesScreen(),
        '/jokes_by_type': (context) => const JokesByTypeScreen(),
        '/random_joke': (context) => const RandomJokeScreen(),
      },
    );
  }
}
