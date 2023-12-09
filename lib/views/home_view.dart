import 'package:day2/components/page_transition_widget.dart';
import 'package:day2/views/single_music_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/card_widget.dart';
import '../components/search_and_filter_widget.dart';
import '../data/music_data_class.dart';
import '../utils/services.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<MusicData> musicList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Explore over \n1m+ AudioBooks",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: const [
          CircleAvatar(
            child: Icon(
              CupertinoIcons.person_alt_circle,
              color: Colors.white,
              size: 32,
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const SearchAndFilterWidget(),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "On Trending",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                    padding: const EdgeInsets.only(left: 20),
                    itemCount: musicList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransitionWidget(
                                  page: SingleMusicView(
                                musicData: musicList[index],
                              )));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          height: 300,
                          width: 160,
                          child: CardWidget(
                            musicData: musicList[index],
                          ),
                        ),
                      );
                    }),
              ),
              const Text(
                "Popular",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                    padding: const EdgeInsets.only(left: 20),
                    itemCount: musicList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 300,
                        width: 160,
                        child: CardWidget(
                          musicData: musicList[index],
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchMusicData();
  }

  Future<void> fetchMusicData() async {
    final musiclist = await ApiService().getAllFetchMusicData();
    setState(() {
      musicList = musiclist;
    });
  }
}
