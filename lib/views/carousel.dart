import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final PageController _pageController = PageController();
  final List<String> images = [
    'assets/gf_banner.jpg',
    'assets/dexter.jpg',
    'assets/spiderman.jpg',
  ];
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Image.asset(
              images[index],
              fit: BoxFit.fill,
            );
          },
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              images.length,
              (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? Colors.white : Colors.grey,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
