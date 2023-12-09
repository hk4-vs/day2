import 'package:audioplayers/audioplayers.dart';
import 'package:day2/data/music_data_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleMusicView extends StatefulWidget {
  const SingleMusicView({super.key, required this.musicData});
  final MusicData musicData;

  @override
  State<SingleMusicView> createState() => _SingleMusicViewState();
}

class _SingleMusicViewState extends State<SingleMusicView> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.chevron_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Music"),
        actions: [
          IconButton(
            icon: const Icon(
              CupertinoIcons.arrowshape_turn_up_right_fill,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            Center(
              child: Card(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.musicData.image.toString(),
                    height: 300,
                    width: 200,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.musicData.title.toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "by${widget.musicData.artist}",
              style: const TextStyle(
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black38),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Slider(
                value: position.inSeconds.toDouble(),
                min: 0,
                activeColor: Theme.of(context).primaryColor,
                max: duration.inSeconds.toDouble(),
                onChanged: (value) async {
                  final position = Duration(seconds: value.toInt());
                  await audioPlayer.seek(position);

                  await audioPlayer.resume();
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatTime(position)),
                  Text(formatTime(duration - position)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black12),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.skip_previous,
                        color: Colors.black45,
                      )),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.3)),
                      padding: const EdgeInsets.all(12),
                      child: Icon(
                        CupertinoIcons.arrow_uturn_left,
                        color: Theme.of(context).primaryColor,
                      )),
                ),
                GestureDetector(
                  onTap: () async {
                    if (isPlaying) {
                      await audioPlayer.pause();
                    } else {
                      await audioPlayer.resume();
                    }
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor),
                      padding: const EdgeInsets.all(24),
                      child: Icon(
                          isPlaying
                              ? CupertinoIcons.pause_fill
                              : CupertinoIcons.play_fill,
                          color: Colors.white)),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Icon(
                        CupertinoIcons.arrow_uturn_right,
                        color: Theme.of(context).primaryColor,
                      )),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black12),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.skip_next,
                        color: Colors.black45,
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> setAudio() async {
    // Repeat song when completed
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    await audioPlayer.setSourceUrl(widget.musicData.source.toString());
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(duration.inHours);
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, twoDigitMinutes, twoDigitSeconds]
        .join(':');
  }

  @override
  void initState() {
    super.initState();

    setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    // listen to audio duration
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    // listen to audio position
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }
}
