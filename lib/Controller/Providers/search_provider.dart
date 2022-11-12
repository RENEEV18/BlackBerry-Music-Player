import 'package:demo/Controller/db/functions/db%20functions.dart';
import 'package:demo/View/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchProvider extends ChangeNotifier{

  List<SongModel> allsong = FavoriteDb().favsongModel;
List<SongModel> song = [];
final audioPlayer = AudioPlayer();
final audiQuery = OnAudioQuery();

  void search(String keyboard) {
    List<SongModel> results = [];
    if (keyboard.isEmpty) {
      results = allsong;
    } else {
      results = allsong
          .where((element) => element.displayNameWOExt
              .toLowerCase()
              .contains(keyboard.toLowerCase()))
          .toList();
    }
   
      song = results;
    notifyListeners();
  }

    void allSongLoad() async {
    allsong = await audiQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    
      song = allsong;
     notifyListeners();
  }
}