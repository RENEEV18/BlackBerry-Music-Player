import 'dart:developer';
import 'package:demo/Controller/db/functions/db%20functions.dart';
import 'package:demo/View/screens/play_music.dart';
import 'package:demo/View/widgets/musicfile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({super.key});

  final audioPlayer = AudioPlayer();

  final audiQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<FavoriteDb>(context, listen: false).getAllMusic();
      },
    );

  
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
        child: Consumer<FavoriteDb>(
          builder: (context, value, child) {
              log('fav rebuilded');
            return CustomScrollView(
            shrinkWrap: true,
            slivers: <Widget>[
              SliverAppBar(  
                leading:  const SizedBox(),
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                expandedHeight: MediaQuery.of(context).size.height * 0.35,
                pinned: true,
                floating: true,
                flexibleSpace: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 37, 2, 61),
                          Color.fromARGB(255, 77, 0, 221),
                          Color.fromARGB(255, 241, 171, 241),
                        ]),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0, 0),
                      child: Center(
                        child: Text(
                          'Liked Songs',
                          style: GoogleFonts.montserrat(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.only(top: 100, left: 20),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                        )),
                    const Padding(
                        padding: EdgeInsets.only(top: 140, left: 20),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                        )),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                sliver: Consumer<FavoriteDb>(
                  builder: (context, value, child) {
                    log('songFav');
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: value.favsongModel.length,
                        (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              List<SongModel> newList = [...value.favsongModel];
        
                              MusicFile.audioPlayer.stop();
                              MusicFile.audioPlayer.setAudioSource(
                                MusicFile.createSongList(newList),
                                initialIndex: index,
                              );
                              MusicFile.audioPlayer.play();
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: ((context) {
                                return MusicScreen(
                                  songModel: newList,
                                  //index: index
                                );
                              })));
                            },
                            title: Text(
                              value.favsongModel[index].title == '<unknown>'
                                  ? 'Unknown Song'
                                  : value.favsongModel[index].title,
                              maxLines: 1,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 15,
                              ),
                            ),
                            subtitle: Text(
                              value.favsongModel[index].artist.toString() ==
                                      '<unknown>'
                                  ? 'Unknown Artist'
                                  : value.favsongModel[index].artist.toString(),
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Color.fromARGB(186, 255, 255, 255),
                                  fontSize: 14),
                            ),
                            trailing: FittedBox(
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      value.removeFav(
                                      
                                      value.favsongModel[index].id);
        
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            '${value.favsongModel[index].title} Unliked',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(
                                              color: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                            ),
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          backgroundColor:
                                              const Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.favorite),
                                    color: Colors.red,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Share.share(
                                          'https://play.google.com/store/apps/details?id=in.brototype.blackberry&hl=en_US&gl=US');
                                    },
                                    icon: const Icon(Icons.share),
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                            leading: QueryArtworkWidget(
                              id: value.favsongModel[index].id,
                              type: ArtworkType.AUDIO,
                              keepOldArtwork: true,
                              nullArtworkWidget: const CircleAvatar(
                                radius: 24,
                                backgroundImage: AssetImage(
                                    'assets/images/music-1085655_960_720.png'),
                              ),
                              quality: 100,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
          },
          
        ),
      ),
    );
  }
}
