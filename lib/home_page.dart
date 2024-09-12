// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // For API requests
import 'movie_details.dart'; // Create a separate page to show movie details

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String apiKey = '9813ce01a72ca1bd2ae25f091898b1c7';
  final String apiUrl =
      'https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=';
  final String imgPath = 'https://image.tmdb.org/t/p/w500/';
  List<dynamic> apiMovies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      var response = await Dio().get('$apiUrl$apiKey');
      setState(() {
        apiMovies = response.data['results'];
      });
    } catch (error) {
      print('Error fetching the data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: apiMovies.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: apiMovies.length,
                itemBuilder: (context, index) {
                  final movie = apiMovies[index];
                  return movieCard(movie, context);
                },
              ),
      ),
    );
  }

  Widget movieCard(dynamic movie, BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          Image.network(
            movie['poster_path'] != null
                ? '$imgPath${movie['poster_path']}'
                : 'https://via.placeholder.com/150',
            fit: BoxFit.cover,
            height: 180,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  movie['title'],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetails(movie: movie),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Show Details',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
