import 'dart:developer';

import 'package:demo/Controller/db/functions/db%20functions.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class PlaylistIconProvider extends ChangeNotifier {
  // IconData icon = Icons.circle_outlined;
  bool onTap = false;

  List<bool>? boolList;

  void generateBoolList(int length) {
    boolList = List.generate(length, (index) => false);
    notifyListeners();
  }

  void buttonClick(BuildContext context, SongModel song, String foldername,
      int length, int index) {
    final provider = Provider.of<FavoriteDb>(context, listen: false);

    if (boolList?[index] == false) {
     
      log('hai');

      provider.addplaylistSongs(song, foldername);
    } else {
      
       provider.removePlaylstSong(song.id, foldername);
      log('yhgu');
    }
    boolList?[index] = !boolList![index];
    notifyListeners();
  }
}
