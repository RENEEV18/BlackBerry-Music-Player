import 'dart:developer';

import 'package:demo/Controller/Providers/home_permission.dart';
import 'package:demo/Controller/Providers/timer_splash_provider.dart';
import 'package:demo/View/screens/play_music.dart';
import 'package:demo/View/widgets/fav_button.dart';
import 'package:demo/View/widgets/musicfile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatelessWidget {
  ListScreen({super.key, required this.audioPlayer, required this.icon});
  final AudioPlayer audioPlayer;
  final IconData icon;
  final audiQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePermissionProvider>(
      builder: (context, value, child) {
        return SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: FutureBuilder<List<SongModel>>(
            future: audiQuery.querySongs(
              sortType: null,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true,
            ),
            builder: (context, item) {
              if (item.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 2,
                ));
              } else if (item.data!.isEmpty) {
                return const Center(
                  heightFactor: 30,
                  child: Text(
                    'No Songs Found',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else {
                return ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        item.data![index].displayNameWOExt,
                        maxLines: 1,
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        item.data![index].artist.toString() == "<unknown>"
                            ? "Unknown Artist"
                            : item.data![index].artist.toString(),
                        maxLines: 1,
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: QueryArtworkWidget(
                          artworkBorder: BorderRadius.circular(5),
                          id: item.data![index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue),
                            child: const Icon(
                              Icons.music_note,
                              color: Colors.white,
                            ),
                          )),
                      trailing: FavoriteButton(
                        song: item.data![index],
                        icon: icon,
                      ),
                      onTap: () {
                        MusicFile.audioPlayer.setAudioSource(
                          MusicFile.createSongList(item.data!),
                          initialIndex: index,
                        );
                        MusicFile.audioPlayer.play();
                        Provider.of<TimerSplash>(context, listen: false)
                            .onTap(context, item);
                      },
                    );
                  },
                  itemCount: item.data!.length,
                );
              }
            },
          ),
        );
      },
    );
  }
}
