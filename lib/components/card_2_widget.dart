import 'package:day2/data/music_data_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class Card2Widget extends StatelessWidget {
  const Card2Widget({super.key, required this.musicData});
  final MusicData musicData;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  musicData.image.toString(),
                  height: 100,
                  width: 100,
                  fit: BoxFit.fitHeight,
                )),
          ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                musicData.title.toString(),
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis),
                maxLines: 10,
              ),
              const RatingStars(
                value: 4.5,
                valueLabelVisibility: false,
                starSize: 10,
              )
            ],
          )
        ],
      ),
    );
  }
}
