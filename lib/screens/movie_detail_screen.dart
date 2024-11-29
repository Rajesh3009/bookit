import 'package:bookit/screens/booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieDetailScreen extends StatelessWidget {
  final Map<String, dynamic> movie;
  final int index;
  final String heroTag;

  const MovieDetailScreen({
    super.key,
    required this.movie,
    required this.index,
    this.heroTag = '',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: heroTag,
                    child: CachedNetworkImage(
                      width: double.infinity,
                      height: 400,
                      imageUrl: movie['image_url'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie['title'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                                'Year: ${movie['year'] ?? 'No year available'}'),
                            const SizedBox(width: 8),
                            Text(movie['runtime'] ?? 'No runtime available'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movie['desc'] ?? 'No description available',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 24),
                        movie['status'] == 'playing'
                            ? SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BookingScreen(movie: movie),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    foregroundColor: Colors.white,
                                    elevation: 3,
                                  ),
                                  child: const Text(
                                    'Book Tickets',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  // Add bottom padding to ensure content isn't hidden behind safe area
                  const SizedBox(height: 24),
                ],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
