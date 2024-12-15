import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/joke_model.dart';
import '../widgets/joke_card.dart';

class JokesByTypeScreen extends StatelessWidget {
  const JokesByTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final type = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('$type Jokes'),
      ),
      body: FutureBuilder<List<Joke>>(
        future: ApiService.getJokesByType(type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No jokes found.'));
          }

          final jokes = snapshot.data!;
          return ListView.builder(
            itemCount: jokes.length,
            itemBuilder: (context, index) {
              return JokeCard(joke: jokes[index]);
            },
          );
        },
      ),
    );
  }
}
