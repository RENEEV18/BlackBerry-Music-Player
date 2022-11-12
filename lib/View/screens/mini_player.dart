import 'package:demo/Controller/Providers/mini_player_provider.dart';
import 'package:demo/View/screens/play_music.dart';
import 'package:demo/View/widgets/animated_text.dart';
import 'package:demo/View/widgets/musicfile.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class MiniplayerScreen extends StatelessWidget {
  const MiniplayerScreen({
    super.key,
    // required this.index,
  });
  //final int index;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MiniPlayerProvider>(context, listen: false).mountedfun();
    });
    return Consumer<MiniPlayerProvider>(
      builder: (context, value, child) {
        return ListTile(
          tileColor: const Color.fromARGB(255, 0, 0, 0),
          contentPadding: const EdgeInsets.all(10),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MusicScreen(
                  songModel: MusicFile.playingSong,
                  //index: index
                ),
              ),
            );
          },
          title: AnimatedText(
            text: MusicFile.playingSong[MusicFile.audioPlayer.currentIndex!]
                        .displayNameWOExt ==
                    "<unknown>"
                ? "Unknown Song"
                : MusicFile.playingSong[MusicFile.audioPlayer.currentIndex!]
                    .displayNameWOExt,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          subtitle: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              MusicFile.playingSong[MusicFile.audioPlayer.currentIndex!].artist
                          .toString() ==
                      "<unknown>"
                  ? "Unknow Artist"
                  : MusicFile
                      .playingSong[MusicFile.audioPlayer.currentIndex!].artist
                      .toString(),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
          ),
          leading: QueryArtworkWidget(
            id: MusicFile.playingSong[MusicFile.audioPlayer.currentIndex!].id,
            type: ArtworkType.AUDIO,
            quality: 100,
            keepOldArtwork: true,
            nullArtworkWidget: const CircleAvatar(
              radius: 24,
              backgroundImage:
                  AssetImage('assets/images/music-1085655_960_720.png'),
            ),
          ),
          trailing: FittedBox(
            fit: BoxFit.fill,
            child: Row(children: [
              IconButton(
                onPressed: () async {
                  if (MusicFile.audioPlayer.hasPrevious) {
                    await MusicFile.audioPlayer.seekToPrevious();
                    await MusicFile.audioPlayer.play();
                  } else {
                    await MusicFile.audioPlayer.play();
                  }
                },
                icon: const Icon(
                  Icons.skip_previous_rounded,
                  color: Color.fromARGB(255, 255, 255, 255),
                  size: 30,
                ),
              ),
              MaterialButton(
                shape: const CircleBorder(),
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
                        Icons.pause_circle_outline,
                        size: 35,
                        color: Color.fromARGB(255, 241, 0, 189),
                      );
                    } else {
                      return const Icon(
                        Icons.play_circle_outline,
                        color: Color.fromARGB(255, 241, 0, 189),
                        size: 35,
                      );
                    }
                  },
                ),
              ),
              IconButton(
                  onPressed: (() async {
                    await MusicFile.audioPlayer.seekToNext();

                    await MusicFile.audioPlayer.play();
                  }),
                  icon: const Icon(
                    Icons.skip_next,
                    color: Color.fromARGB(255, 255, 255, 255),
                    size: 30,
                  )),
            ]),
          ),
        );
      },
    );
  }
}
