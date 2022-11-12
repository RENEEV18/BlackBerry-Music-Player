
import 'package:demo/Controller/Providers/now_playing_provider.dart';
import 'package:demo/View/widgets/musicfile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';


class MusicScreen extends StatelessWidget {
  MusicScreen({
    super.key,
    required this.songModel,
  });

  final List<SongModel> songModel;

  Color iconcolor = Colors.grey;

  bool isPlaying = false;

  int currentIndex = 0;

  bool isShuffle = true;

   bool isFav = false;

  bool isRepeat = true;

  IconData playbutton = Icons.pause;

  String time(Duration duration) {
    String twodigits(int n) => n.toString().padLeft(2, '0');
    final hours = twodigits(duration.inHours);
    final minutes = twodigits(
      duration.inMinutes.remainder(60),
    );
    final seconds = twodigits(
      duration.inSeconds.remainder(60),
    );

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(":");
  }

  Widget slider(BuildContext context) => Slider.adaptive(
        activeColor: const Color.fromARGB(255, 241, 0, 189),
        inactiveColor: const Color.fromARGB(255, 255, 255, 255),
        value: Provider.of<NowPlayingProvider>(context, listen: false)
            .position
            .inSeconds
            .toDouble(),
        max: Provider.of<NowPlayingProvider>(context, listen: false)
            .musicLength
            .inSeconds
            .toDouble(),
        onChanged: ((value) {
          onChanged(value.toInt());
          value = value;
        }),
      );

  @override
  Widget build(BuildContext context) {
    
    final provider = Provider.of<NowPlayingProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     
      Provider.of<NowPlayingProvider>(context, listen: false).mountedfun();
      
    });
    //  Provider.of<IsFavProvider>(context,listen: false).checkFav(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
          ),
        ],
        title: Center(
            child: Text(
          'Now Playing',
          style: GoogleFonts.montserrat(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 18,
          ),
        )),
        leading: IconButton(
          onPressed: () {
            provider;
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
        child: Consumer<NowPlayingProvider>(
          builder: (context, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipPath(
                  clipper: WaveClipper(),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        height: 440,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 140),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            QueryArtworkWidget(
                                keepOldArtwork: true,
                                quality: 100,
                                artworkHeight: 220,
                                artworkWidth: 220,
                                artworkBorder: const BorderRadius.all(
                                    Radius.circular(140)),
                                id: songModel[value.currentIndex].id,
                                nullArtworkWidget: const CircleAvatar(
                                  radius: 110,
                                  backgroundImage: AssetImage(
                                      'assets/images/music-1085655_960_720.png'),
                                ),
                                type: ArtworkType.AUDIO),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, right: 40),
                              child: Text(
                                songModel[value.currentIndex]
                                            .displayNameWOExt ==
                                        "<unknown>"
                                    ? "Unknown Song"
                                    : songModel[value.currentIndex]
                                        .displayNameWOExt,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 60, right: 60),
                              child: Text(
                                songModel[value.currentIndex]
                                            .artist
                                            .toString() ==
                                        "<unknown>"
                                    ? "Unknown Artist"
                                    : songModel[value.currentIndex]
                                        .artist
                                        .toString(),
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color.fromARGB(171, 0, 0, 0),
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                slider(context),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        time(value.position),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        time(value.musicLength - value.position),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isShuffle ? Colors.grey : Colors.white,
                        ),
                        child: IconButton(
                          onPressed: () async {
                            if (isShuffle) {
                              MusicFile.audioPlayer.shuffle();
                              MusicFile.audioPlayer.setShuffleModeEnabled(true);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Shuffle Enabled',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  margin: const EdgeInsets.only(
                                      left: 100, right: 100, bottom: 10),
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(milliseconds: 500),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                              );
                            } else {
                              MusicFile.audioPlayer
                                  .setShuffleModeEnabled(false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Shuffle Disabled',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  margin: const EdgeInsets.only(
                                      left: 100, right: 100, bottom: 10),
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(milliseconds: 500),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                              );
                            }
                            isShuffle = !isShuffle;
                            value.notifyListeners();
                          },
                          icon: const Icon(Icons.shuffle),
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: IconButton(
                          onPressed: () async {
                            if (MusicFile.audioPlayer.hasPrevious) {
                              isPlaying = true;
                              await MusicFile.audioPlayer.seekToPrevious();
                              await MusicFile.audioPlayer.play();
                            } else {
                              await MusicFile.audioPlayer.play();
                            }
                           
                          },
                          icon: const Icon(
                            Icons.skip_previous,
                            size: 40,
                          ),
                        ),
                      ),
                      MaterialButton(
                        height: 75,
                        shape: const CircleBorder(),
                        color: Colors.white,
                        onPressed: () async {
                          if (MusicFile.audioPlayer.playing) {
                            await MusicFile.audioPlayer.pause();
                          } else {
                            await MusicFile.audioPlayer.play();
                          }
                        },
                        child: StreamBuilder<bool>(
                          stream: MusicFile.audioPlayer.playingStream,
                          builder: (context, snapshot) {
                            bool? playingStage = snapshot.data;
                            if (playingStage != null && playingStage) {
                              return const Icon(
                                Icons.pause_rounded,
                                size: 45,
                                color: Color.fromARGB(255, 0, 0, 0),
                              );
                            } else {
                              return const Icon(
                                Icons.play_arrow_rounded,
                                color: Color.fromARGB(255, 0, 0, 0),
                                size: 55,
                              );
                            }
                          },
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: IconButton(
                          onPressed: () async {
                            await MusicFile.audioPlayer.seekToNext();
                          
                          },
                          icon: const Icon(
                            Icons.skip_next,
                            size: 40,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isRepeat ? Colors.grey : Colors.white,
                        ),
                        child: IconButton(
                          onPressed: () async {
                            if (isRepeat) {
                              MusicFile.audioPlayer.setLoopMode(LoopMode.one);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Loop Enabled',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  margin: const EdgeInsets.only(
                                      left: 100, right: 100, bottom: 10),
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(milliseconds: 500),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                              );
                            } else {
                              MusicFile.audioPlayer.setLoopMode(LoopMode.off);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Loop Disabled',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  margin: const EdgeInsets.only(
                                      left: 100, right: 100, bottom: 10),
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(milliseconds: 500),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                              );
                            }
                            isRepeat = !isRepeat;
                            value.notifyListeners();
                          },
                          icon: const Icon(
                            Icons.repeat,
                          ),
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      )
                    ]),
                const SizedBox(height: 20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                  
                //        FavoriteButton(song: songModel[value.currentIndex], icon: Icons.favorite),
                      
                        
                    
                //     IconButton(
                //         onPressed: () {
                //           Share.share(
                //               'https://play.google.com/store/apps/details?id=in.brototype.blackberry&hl=en_US&gl=US');
                //         },
                //         icon: const Icon(
                //           Icons.share_rounded,
                //           color: Color.fromARGB(153, 255, 255, 255),
                //         ))
                //   ],
                // ),
              ],
            );
          },
        ),
      ),
    );
  }

  // void checkFav(BuildContext context) async {
   
  //   isFav = await FavoriteDb().isFav(songModel[currentIndex].id);
  //   //music.notifyListeners();
  // }

  void onChanged(int seconds) {
    Duration duration = Duration(seconds: seconds);
    MusicFile.audioPlayer.seek(duration);
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = Path();
    path.lineTo(0, size.height - 30);

    var start = Offset(size.width / 6, size.height);
    var end = Offset(size.width / 2, size.height - 90);
    path.quadraticBezierTo(start.dx, start.dy, end.dx, end.dy);

    var secondstart = Offset(size.width, size.height - 220);
    var secondend = Offset(size.width, size.height - 90);
    path.quadraticBezierTo(
        secondstart.dx, secondstart.dy, secondend.dx, secondend.dy);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
