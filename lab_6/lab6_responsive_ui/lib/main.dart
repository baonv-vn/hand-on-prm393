import 'package:flutter/material.dart';

void main() {
  runApp(const ResponsiveMovieApp());
}

const double kTabletBreakpoint = 800;

class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  const Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });
}

const List<Movie> allMovies = [
  Movie(title: 'Inception', year: 2010, genres: ['Sci-Fi', 'Thriller'], posterUrl: 'https://picsum.photos/200/300?1', rating: 8.8),
  Movie(title: 'The Notebook', year: 2004, genres: ['Romance', 'Drama'], posterUrl: 'https://picsum.photos/200/300?2', rating: 7.8),
  Movie(title: 'Superbad', year: 2007, genres: ['Comedy'], posterUrl: 'https://picsum.photos/200/300?3', rating: 7.6),
  Movie(title: 'Interstellar', year: 2014, genres: ['Sci-Fi', 'Drama'], posterUrl: 'https://picsum.photos/200/300?4', rating: 8.6),
  Movie(title: 'Mad Max: Fury Road', year: 2015, genres: ['Action', 'Sci-Fi'], posterUrl: 'https://picsum.photos/200/300?5', rating: 8.1),
];

const List<String> genres = ['Action', 'Drama', 'Comedy', 'Sci-Fi', 'Romance', 'Thriller'];

class ResponsiveMovieApp extends StatelessWidget {
  const ResponsiveMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: GenreScreen()
    );
  }
}

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  String searchQuery = '';
  Set<String> selectedGenres = {};
  String selectedSort = 'A-Z';

  List<Movie> get visibleMovies {
    final result = allMovies.where((movie) {
      final matchesSearch = movie.title.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesGenre = selectedGenres.isEmpty ||
          selectedGenres.any((g) => movie.genres.contains(g));
      return matchesSearch && matchesGenre;
    }).toList();

    switch (selectedSort) {
      case 'A-Z':
        result.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Z-A':
        result.sort((a, b) => b.title.compareTo(a.title));
        break;
      case 'Year':
        result.sort((a, b) => a.year.compareTo(b.year));
        break;
      case 'Rating':
        result.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final movies = visibleMovies;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= kTabletBreakpoint;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Find a Movie',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      onChanged: (value) => setState(() => searchQuery = value),
                      decoration: const InputDecoration(
                        hintText: 'Search movies...',
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: genres.map((genre) {
                      final isSelected = selectedGenres.contains(genre);
                      return ChoiceChip(
                        label: Text(genre),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              selectedGenres.add(genre);
                            } else {
                              selectedGenres.remove(genre);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  DropdownButton<String>(
                    value: selectedSort,
                    items: const [
                      DropdownMenuItem(value: 'A-Z', child: Text('A-Z')),
                      DropdownMenuItem(value: 'Z-A', child: Text('Z-A')),
                      DropdownMenuItem(value: 'Year', child: Text('Year')),
                      DropdownMenuItem(value: 'Rating', child: Text('Rating')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => selectedSort = value);
                      }
                    },
                  ),

                  Expanded(
                    child: movies.isEmpty
                        ? const Center(child: Text('Không có phim phù hợp'))
                        : isWide
                        ? GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      children: movies.map((m) => MovieCard(movie: m)).toList(),
                    )
                        : ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) => MovieCard(movie: movies[index]),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final posterWidth = constraints.maxWidth >= 360 ? 120.0 : 80.0;
          final posterHeight = posterWidth * 1.5;

          return Row(
            children: [
              Image.network(
                movie.posterUrl,
                width: posterWidth,
                height: posterHeight,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: posterWidth,
                  height: posterHeight,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.movie),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(movie.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('${movie.year}'),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(movie.rating.toStringAsFixed(1)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(movie.genres.join(', '),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
