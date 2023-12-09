import 'package:day2/data/music_data_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.musicData});
  final MusicData musicData;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 0.5,
            margin: EdgeInsets.zero,
            child: Stack(children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    musicData.image.toString(),
                    height: 200,
                    width: 160,
                    fit: BoxFit.fitHeight,
                  )),
              Positioned(
                bottom: 20,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: musicData.totalTrackCount == 13
                          ? Colors.black.withOpacity(0.2)
                          : Colors.white.withOpacity(0.5),
                      shape: BoxShape.circle),
                  child: const Center(
                      child: Icon(
                    CupertinoIcons.heart,
                    color: Colors.white,
                  )),
                ),
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  musicData.title.toString(),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis),
                  maxLines: 2,
                ),
                const RatingStars(
                  value: 4.5,
                  valueLabelVisibility: false,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
