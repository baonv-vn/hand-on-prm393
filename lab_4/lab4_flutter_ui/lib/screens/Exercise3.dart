import 'package:flutter/material.dart';

class Exercise3 extends StatelessWidget {
  const Exercise3({super.key});

  static const List<String> _movies = [
    'Avatar',
    'Inception',
    'Interstellar',
    'Joker'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise 3 - Layout Demo'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Now Playing',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final movie = _movies[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text(movie[0]),),
                    title: Text(movie),
                    subtitle: Text('Sample description'),
                  ),
                );
              },
            ),
          )
        ],
      )
    );
  }
}