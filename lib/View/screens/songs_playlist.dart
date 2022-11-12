import 'dart:developer';
import 'package:demo/Controller/Providers/now_playing_provider.dart';
import 'package:demo/Controller/db/functions/db%20functions.dart';
import 'package:demo/View/screens/play_music.dart';
import 'package:demo/View/screens/selection_playlis.dart';
import 'package:demo/View/widgets/musicfile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class SongsPlaylist extends StatelessWidget {
  SongsPlaylist({super.key, required this.foldername});
  final String foldername;

  final _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    Provider.of<FavoriteDb>(context, listen: false)
        .getAllPlayListSongs(foldername);

    //FocusManager.instance.primaryFocus?.unfocus();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Consumer<FavoriteDb>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: SafeArea(
              child: Column(
                children: [
                  Text(
                    foldername.toUpperCase(),
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  FutureBuilder<List<SongModel>>(
                    future: _audioQuery.querySongs(
                      sortType: null,
                      orderType: OrderType.ASC_OR_SMALLER,
                      uriType: UriType.EXTERNAL,
                      ignoreCase: true,
                    ),
                    builder: (context, item) {
                      if (item.data == null) {
                        return LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.black,
                          size: 40,
                        );
                      } else if (item.data!.isEmpty) {
                        return const SizedBox(
                          height: 200,
                          child: Center(
                            child: Text(
                              'No Songs Found',
                            ),
                          ),
                        );
                      }

                      return value.songsPlaylist.isNotEmpty
                          ? ListView.builder(
                              itemBuilder: ((context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text(
                                      value.songsPlaylist[index].title,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    subtitle: Text(
                                      value.songsPlaylist[index].artist ??
                                          'Unknown Artist',
                                      maxLines: 1,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      List<SongModel> newList = [
                                        ...value.songsPlaylist
                                      ];
                                      MusicFile.audioPlayer.setAudioSource(
                                        MusicFile.createSongList(newList),
                                        initialIndex: index,
                                      );
                                      MusicFile.audioPlayer.play();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: ((context) {
                                            return MusicScreen(
                                              songModel: value.songsPlaylist,
                                              // index: index,
                                            );
                                          }),
                                        ),
                                      );
                                    },
                                    leading: QueryArtworkWidget(
                                      id: value.songsPlaylist[index].id,
                                      type: ArtworkType.AUDIO,
                                      quality: 100,
                                      nullArtworkWidget: const CircleAvatar(
                                        radius: 24,
                                        backgroundImage: AssetImage(
                                            'assets/images/music-1085655_960_720.png'),
                                      ),
                                      keepOldArtwork: true,
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        value.removePlaylstSong(
                                            value.songsPlaylist[index].id,
                                            foldername);
                                        SnackBar(
                                          content: Text(
                                            '${value.songsPlaylist[index].title} removed',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(
                                              color: const Color.fromARGB(
                                                  255, 0, 0, 0),
                                            ),
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          backgroundColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.delete_sweep_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              itemCount: value.songsPlaylist.length,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                            )
                          : Center(
                              heightFactor: 2,
                              child: Lottie.asset(
                                  'assets/images/20546-i-stay-at-home.json',
                                  height: 300,
                                  width: 300),
                            );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
            return SelectionScreen(
              foldername: foldername,
            );
          })));
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.playlist_add_rounded,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }
}
