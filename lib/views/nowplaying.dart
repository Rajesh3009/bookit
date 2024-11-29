import 'package:bookit/screens/booking_screen.dart';
import 'package:bookit/services/api.dart';
import 'package:bookit/utils/constants.dart';
import 'package:bookit/screens/movie_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NowPlaying extends ConsumerStatefulWidget {
  const NowPlaying({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NowPlayingState();
}

class _NowPlayingState extends ConsumerState<NowPlaying> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Api().getNowPlayingMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data;
        if (data == null) return const SizedBox.shrink();

        return Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 15),
            _buildMovieList(data),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Now Playing",
          style: TextStyle(
            color: Colors.black,
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Text(
          'View All >',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  Widget _buildMovieList(List<dynamic> data) {
    return SizedBox(
      height: 350,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _buildMovieCard(data[index], index);
        },
      ),
    );
  }

  Widget _buildMovieCard(dynamic movie, int index) {
    final heroTag = 'movie-${movie['title']}';

    return SizedBox(
      height: 210,
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
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
          const SizedBox(height: 10),
          _buildMovieTitle(movie),
          _buildBookingButton(movie),
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
          height: 220,
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

  Widget _buildBookingButton(dynamic movie) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BookingScreen(
                    movie: movie,
                  )),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1.0, color: Colors.orange),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: const Text("Book Now"),
    );
  }
}
