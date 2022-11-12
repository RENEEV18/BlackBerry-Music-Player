import 'package:demo/Controller/Providers/search_provider.dart';
import 'package:demo/View/screens/home.dart';
import 'package:demo/View/screens/play_music.dart';
import 'package:demo/View/widgets/musicfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<SearchProvider>(context, listen: false).allSongLoad();
    return Scaffold(
      appBar: AppBar(
       leading: const Icon(Icons.notifications_active,color: Colors.white,),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: Consumer<SearchProvider>(
          builder: (context, value, child) {
            return CupertinoSearchTextField(
              backgroundColor: Colors.white,
              borderRadius: BorderRadius.circular(20),
              itemColor: Colors.black,
              controller: searchController,
              onChanged: (song) {
                value.search(song);
              },
            );
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SafeArea(
          child: Consumer<SearchProvider>(
            builder: (context, value, child) {
              return Column(
                children: [
                  value.song.isNotEmpty
                      ? ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                value.song[index].displayNameWOExt,
                                maxLines: 1,
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                " ${value.song[index].artist}",
                                maxLines: 1,
                                style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              leading: QueryArtworkWidget(
                                id: value.song[index].id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: const CircleAvatar(
                                  radius: 24,
                                  backgroundImage: AssetImage(
                                      'assets/images/music-1085655_960_720.png'),
                                ),
                              ),
                              onTap: () {
                                MusicFile.audioPlayer.setAudioSource(
                                  MusicFile.createSongList(value.song),
                                  initialIndex: index,
                                );
                                MusicFile.audioPlayer.play();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: ((context) {
                                      return MusicScreen(
                                        songModel: value.song,
                                        //index: index,
                                      );
                                    }),
                                  ),
                                );
                              },
                            );
                          },
                          itemCount: value.song.length,
                        )
                      : const Center(
                          heightFactor: 2.5,
                          child: Image(
                            image: AssetImage(
                              'assets/images/212-2129001_mobile-app-development-services-business-login-illustration-png.png',
                            ),
                            height: 220,
                            width: 220,
                          ),
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}


