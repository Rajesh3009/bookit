import 'package:bookit/views/comingsoon.dart';
import 'package:bookit/views/homeview.dart';
import 'package:bookit/views/nowplaying.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);
final pageControllerProvider = Provider((ref) => PageController());

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.watch(pageControllerProvider);
    final currentIndex = ref.watch(currentIndexProvider);

    final List<Widget> pages = [
      const HomeView(),
      const NowPlaying(),
      const ComingSoon(),
    ];

    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: pageController,
          onPageChanged: (index) {
            ref.read(currentIndexProvider.notifier).update((_) => index);
          },
          children: pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'My Tickets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
