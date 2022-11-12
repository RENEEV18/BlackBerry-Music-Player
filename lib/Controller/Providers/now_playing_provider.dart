import 'dart:developer';
import 'package:demo/Controller/db/functions/db%20functions.dart';
import 'package:demo/View/widgets/musicfile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlayingProvider extends ChangeNotifier {
  bool isShuffle = true;
  bool isFav = false;
  final List<SongModel> songModel = MusicFile.playingSong;
  Duration position = const Duration();

  Duration musicLength = const Duration();
  int currentIndex = 0;
  mountedfun() {
    MusicFile.audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        notifyListeners();
        currentIndex = index;
        MusicFile.currentIndex = index;
        checkFav();
      }

      notifyListeners();
    });

    MusicFile.audioPlayer.durationStream.listen((Duration? d) {
      try {
        if (d == null) {
          return;
        }
        musicLength = d;
        notifyListeners();
      } catch (e) {
        log(e.toString());
      }
    });

    MusicFile.audioPlayer.positionStream.listen((p) {
      position = p;
      notifyListeners();
    });
  }

  void checkFav() async {
    isFav = await FavoriteDb().isFav(songModel[currentIndex].id);
    notifyListeners();
    //music.notifyListeners();
  }
}
