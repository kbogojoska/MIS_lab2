import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/joke_model.dart';
import '../widgets/joke_card.dart';

class RandomJokeScreen extends StatelessWidget {
  const RandomJokeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Joke'),
      ),
      body: FutureBuilder<Joke>(
        future: ApiService.getRandomJoke(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final joke = snapshot.data;
          return joke == null
              ? const Center(child: Text('No joke available.'))
              : Padding(
            padding: const EdgeInsets.all(16.0),
            child: JokeCard(joke: joke),
          );
        },
      ),
    );
  }
}
