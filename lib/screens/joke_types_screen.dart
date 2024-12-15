import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/joke_type_card.dart';

class JokeTypesScreen extends StatelessWidget {
  const JokeTypesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joke types', style: TextStyle(color: Color.fromRGBO(0, 76, 0, 1), fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Image.asset(
                'assets/random_button.png',
                width: 28,
                height: 28,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/random_joke');
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: ApiService.getJokeTypes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No joke types found.'));
          }

          final jokeTypes = snapshot.data!;
          return ListView.builder(
            itemCount: jokeTypes.length,
            itemBuilder: (context, index) {
              final type = jokeTypes[index];
              return JokeTypeCard(
                type: type,
                onTap: () {
                  Navigator.pushNamed(context, '/jokes_by_type', arguments: type);
                },
              );
            },
          );
        },
      ),
    );
  }
}
