import 'package:demo/Controller/db/functions/db%20functions.dart';
import 'package:demo/View/screens/songs_playlist.dart';
import 'package:demo/View/widgets/add_playlist.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<FavoriteDb>(context, listen: false).getPlaylist();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            SliverAppBar(
              leading: const SizedBox(),
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              expandedHeight: MediaQuery.of(context).size.height * 0.35,
              pinned: true,
              floating: true,
             
              flexibleSpace: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                      ),
                
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/hand-man-person-music-black-and-white-white-photography-portrait-studio-hat-darkness-clothing-black-monochrome-dj-audio-headphones-glasses-cap-photograph-eyewear-sound-hifi-mp3-listen.jpg'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(-0.90, 0.98),
                    child: SizedBox(
                      width: 140,
                      height: 60,
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              'Playlist '.toUpperCase(),
                              style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255)),
                            ),
                            const Icon(
                              Icons.bookmark_rounded,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              sliver: Consumer<FavoriteDb>(
                builder: (context, value, child) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: value.playlistModel.length,
                      (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ListTile(
                            title: Text(
                              value.playlistModel[index].playlistname,
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                              ),
                            ),
                            leading: Container(
                              height: 60,
                              width: 60,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                              ),
                              child: const Icon(
                                Icons.music_note_rounded,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: ((context) {
                                    return SongsPlaylist(
                                        foldername: value
                                            .playlistModel[index].playlistname);
                                  }),
                                ),
                              );
                            },
                            onLongPress: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Delete Playlist'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: const [
                                          Text('Are you sure want to delete?'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('No'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Yes'),
                                        onPressed: () {
                                          value.removePlayLst(value
                                              .playlistModel[index]
                                              .playlistname);

                                          Navigator.of(context).pop();
                                          message(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const Padding(
        padding: EdgeInsets.all(5.0),
        child: AddPlaylist(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  void message(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Successfully deleted',
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            color: const  Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        margin: const EdgeInsets.only(left: 60, right: 60, bottom: 10),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: const  Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }
}


