import 'package:bookit/routes/routes.dart';
import 'package:bookit/views/carousel.dart';
import 'package:bookit/views/comingsoon.dart';
import 'package:bookit/views/nowplaying.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildHomeTab();
  }

  Widget _buildHomeTab() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.location_on),
                      onPressed: () {
                        // Add location handling logic here
                      },
                    ),
                    const Text(
                      'Ranchi',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signOut();
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.login);
                      }
                    } catch (error) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Logout failed: $error'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            const SizedBox(
              width: double.infinity,
              height: 200,
              child: Carousel(),
            ),
            const SizedBox(height: 15),
            const NowPlaying(),
            const SizedBox(height: 15),
            const ComingSoon(),
          ],
        ),
      ),
    );
  }
}
