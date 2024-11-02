import 'package:bookit/services/api.dart';
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
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: json.length,
    
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Image.network(json['movies'][index]['image_url'],
                  width: 150, height: 150),
              Text(json['movies'][index]['title']),
            ],
          );
        });
  }
}
