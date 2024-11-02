import 'package:bookit/services/api.dart';
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
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: json['movies'].length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            clipBehavior: Clip.antiAlias, // Add rounded corners
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Align items to the start
              children: [
                Image.network(json['movies'][index]['image_url'],
                    width: 150,
                    height: 200,
                    fit: BoxFit.cover), // Adjust image size and fit
                Padding(
                  padding: const EdgeInsets.all(8.0), // Add padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        json['movies'][index]['title'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold), // Make title bold
                      ),
                      // Add more movie details here if available in your JSON data
                      // e.g., Text('Genre: ${json['movies'][index]['genre']}'),
                      //       Text('Rating: ${json['movies'][index]['rating']}'),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
