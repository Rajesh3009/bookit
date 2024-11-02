import 'package:bookit/views/carousel.dart';
import 'package:bookit/views/nowplaying.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Search",
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text("Location"),
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Carousel(),
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Now Playing",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      'View All >',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 400,
                  child: NowPlaying(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
