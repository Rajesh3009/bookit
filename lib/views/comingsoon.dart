import 'package:bookit/services/api.dart';
import 'package:bookit/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComingSoon extends ConsumerWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final json = Api().loadData();
    return Column(
      children: [
        const Row(
          children: [
            Text(
              "Coming Soon",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              "View All >",
              style: TextStyle(
                  fontSize: subtitleFontSize, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
            height: 350,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: json['movies'].length,
                shrinkWrap: false,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: SizedBox(
                      height: 210,
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Align items to the start
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: const Offset(
                                      2, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                json['movies'][index]['image_url'],
                                width: 180,
                                height: 220,
                                fit: BoxFit.fill, // Adjust image size and fit
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Flexible(
                            child: Text(
                              json['movies'][index]['title'],
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: titleFontSize,
                              ),
                              overflow:
                                  TextOverflow.ellipsis, // Handle overflow
                              maxLines:
                                  3, // Allow text to wrap to a second line
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }))
      ],
    );
  }
}
