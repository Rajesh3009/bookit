import 'package:bookit/screens/movielist_screen.dart';
import 'package:bookit/services/api.dart';
import 'package:bookit/utils/constants.dart';
import 'package:bookit/screens/movie_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComingSoon extends ConsumerWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: Api().getUpcomingMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data;
        if (data == null) return const SizedBox.shrink();

        return Column(
          children: [
            Row(
              children: [
                Text(
                  "Coming Soon",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovielistScreen('upcoming'),
                    ),
                  ),
                  child: Text(
                    "View All >",
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 350,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                shrinkWrap: false,
                itemBuilder: (context, index) {
                  final movie = data[index];
                  final heroTag = movie['id'] != null
                      ? 'upcoming-${movie['id']}'
                      : 'upcoming-index-$index';

                  return GestureDetector(
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: SizedBox(
                        height: 210,
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Hero(
                              tag: heroTag,
                              child: Container(
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
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Flexible(
                              child: Text(
                                movie['title'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: titleFontSize,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
