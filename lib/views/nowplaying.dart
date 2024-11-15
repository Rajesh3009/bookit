import 'package:bookit/services/api.dart';
import 'package:bookit/utils/constants.dart';
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
    final json = Api().loadData();
    return Column(
      children: [
        const Row(
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
                fontSize: subtitleFontSize,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 350,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: json['movies'].length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final movie = json['movies'][index];
              return SizedBox(
                height: 210,
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
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
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 55,
                      child: Text(
                        movie['title'],
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: titleFontSize,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Add your booking logic here
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1.0, color: Colors.orange),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      child: const Text("Book Now"),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
