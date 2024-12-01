import 'package:bookit/services/api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/constants.dart';
import 'export.dart';

class MovielistScreen extends ConsumerWidget {
  final String movieType;
  const MovielistScreen(this.movieType, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(),
        body: SizedBox(
          width: double.infinity,
          child: FutureBuilder(
            future: movieType == "nowplaying"
                ? Api().getNowPlayingMovies()
                : Api().getUpcomingMovies(),
            builder: (context, snapshot) {
              final movieList = snapshot.data;

              if (movieList == null) {
                return const Center(child: CircularProgressIndicator());
              }

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemCount: movieList.length, // Corrected itemCount
                itemBuilder: (context, index) {
                  return _buildMovieCard(movieList[index], index, context);
                },
              );
            },
          ),
        ));
  }

  Widget _buildMovieCard(dynamic movie, int index, BuildContext context) {
    final heroTag = 'movie-${movie['title']}';

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailScreen(
                      movie: movie,
                      index: index,
                      heroTag: heroTag,
                    ),
                  ),
                );
              },
              child: Hero(
                tag: heroTag,
                child: _buildMovieImage(movie),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _buildMovieTitle(movie),
          ),
          // _buildBookingButton(movie),
        ],
      ),
    );
  }

  Widget _buildMovieImage(dynamic movie) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          width: 180,
          height: 240,
          imageUrl: movie['image_url'],
          placeholder: (context, url) => Container(
            color: Colors.grey[300],
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[300],
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 30),
                SizedBox(height: 8),
                Text('Image not available', textAlign: TextAlign.center),
              ],
            ),
          ),
          maxHeightDiskCache: 1000,
        ),
      ),
    );
  }

  Widget _buildMovieTitle(dynamic movie) {
    return SizedBox(
      height: 55,
      child: Text(
        movie['title'] ?? 'No Title',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: titleFontSize,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }
}
