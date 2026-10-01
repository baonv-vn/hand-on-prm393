import 'package:flutter/material.dart';
import 'package:movie_app/data/sample_data.dart';
import 'package:movie_app/models/Movie.dart';
import 'package:movie_app/screens/movie_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movie')),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: sampleMovies.length,
        itemBuilder: (context, index) {
          return _MovieTile(movie: sampleMovies[index]);
        },
      ),
    );
  }
}

class _MovieTile extends StatelessWidget {
  final Movie movie;

  const _MovieTile({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            movie.posterUrl,
            width: 80,
            height: 56,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(movie.title),
        subtitle: Text('\u2606 ${movie.rating} \u2022 ${movie.genres.join(', ')}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(movie: movie),
            ),
          );
        }
      ),
    );
  }
}