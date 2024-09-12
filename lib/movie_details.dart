import 'package:flutter/material.dart';

class MovieDetails extends StatelessWidget {
  final dynamic movie;

  const MovieDetails({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    const String imgPath = 'https://image.tmdb.org/t/p/w500/';
    return Scaffold(
      appBar: AppBar(
        title: Text(movie['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(
              movie['poster_path'] != null
                  ? '$imgPath${movie['poster_path']}'
                  : 'https://via.placeholder.com/150',
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              movie['title'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(movie['overview']),
          ],
        ),
      ),
    );
  }
}
