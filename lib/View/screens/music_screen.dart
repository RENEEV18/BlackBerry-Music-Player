import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo/Controller/Providers/home_permission.dart';
import 'package:demo/Controller/db/functions/db%20functions.dart';
import 'package:demo/View/screens/play_music.dart';
import 'package:demo/View/screens/settings.dart';
import 'package:demo/View/widgets/listview.dart';
import 'package:demo/View/widgets/musicfile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../widgets/fonts.dart';

class ThirdScreen extends StatelessWidget {
  ThirdScreen({Key? key}) : super(key: key);

  final audioPlayer = AudioPlayer();

  final audiQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     
    Provider.of<HomePermissionProvider>(context, listen: false)
        .permissionRequest();
   
   },);

    log('rebuilded home');
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Textfont5(),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const SettingScreen();
                      }));
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<HomePermissionProvider>(
                builder: (context, value, child) {
                  return FutureBuilder<List<SongModel>>(
                    future: audiQuery.querySongs(
                      sortType: null,
                      orderType: OrderType.DESC_OR_GREATER,
                      uriType: UriType.EXTERNAL,
                      ignoreCase: true,
                    ),
                    builder: (context, item) {
                      if (item.connectionState == ConnectionState.waiting) {
                        return const Center(child:  CircularProgressIndicator(strokeWidth: 2,));
                      } else if (item.data!.isEmpty) {
                        return const  Center(
                          child:  Text(
                            'No Songs Found',
                            style: TextStyle(color: Colors.white),
                            
                          ),
                        );
                      } else {
                        return CarouselSlider.builder(
                            itemCount: item.data!.length,
                            itemBuilder: (context, index, realIndex) {
                              return GestureDetector(
                                onTap: () {
                                  MusicFile.audioPlayer.setAudioSource(
                                    MusicFile.createSongList(item.data!),
                                    initialIndex: index,
                                  );
                                  MusicFile.audioPlayer.play();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return MusicScreen(
                                            songModel: item.data!,
                                            // index: index
                                             );
                                      },
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 5,
                                  child: QueryArtworkWidget(
                                      id: item.data![index].id,
                                      type: ArtworkType.AUDIO,
                                      quality: 100,
                                      keepOldArtwork: true,
                                      artworkFit: BoxFit.fill,
                                      artworkBorder: BorderRadius.circular(10),
                                      nullArtworkWidget: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                          child: const Icon(
                                            Icons.music_note,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            size: 80,
                                          ))),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              viewportFraction: 0.4,
                              enableInfiniteScroll: true,
                              disableCenter: true,
                              autoPlayAnimationDuration: const Duration(
                                seconds: 3,
                              ),
                              autoPlayInterval: const Duration(
                                seconds: 3,
                              ),
                              autoPlay: true,
                              enlargeCenterPage: true,
                              height: 150,
                            ));
                      }
                    });
                },
              
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                    child: CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                    child: CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 10,
              ),
              ListScreen(
                audioPlayer: audioPlayer,
                icon: Icons.favorite,
              ),
            ],
          ),
        )));
  }
}
