import 'package:bookit/views/homeview.dart';
import 'package:bookit/views/profileview.dart';
import 'package:bookit/views/ticketsview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentIndexProvider = StateProvider.autoDispose<int>((ref) => 0);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = PageController();
    final currentIndex = ref.watch(currentIndexProvider);

    final List<Widget> pages = [
      const HomeView(),
      const TicketsView(),
      const ProfileView(),
    ];

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: pageController,
              onPageChanged: (index) {
                ref.read(currentIndexProvider.notifier).update((_) => index);
              },
              children: pages,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: BottomNavigationBar(
                    currentIndex: currentIndex,
                    onTap: (index) {
                      pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.white.withOpacity(0.8),
                    elevation: 0,
                    unselectedItemColor: Colors.black54,
                    selectedItemColor: Colors.deepPurple,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
