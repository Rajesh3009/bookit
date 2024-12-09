// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bookit/views/carousel.dart';
import 'package:bookit/views/comingsoon.dart';
import 'package:bookit/views/nowplaying.dart';

import '../screens/export.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8.5),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Search",
                        hintText: "Enter a search term",
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  MyIconBtn(
                    title: 'Ranchi',
                    icon: Icons.location_on,
                  ),
                  const SizedBox(width: 10),
                  MyIconBtn(
                      title: 'Wallet',
                      icon: Icons.account_balance_wallet_rounded,
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WalletPage(), // Navigate to WalletPage
                            ),
                          )),
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
      ),
    );
  }
}

class MyIconBtn extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final IconData? icon;
  const MyIconBtn({
    super.key,
    required this.title,
    this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(icon),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
