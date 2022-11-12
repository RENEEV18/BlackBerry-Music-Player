import 'dart:async';

import 'package:demo/View/screens/home.dart';
import 'package:demo/View/screens/play_music.dart';
import 'package:demo/View/widgets/musicfile.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class TimerSplash with ChangeNotifier {
  void timeSplash(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) {
          return HomeScreen();
        },
      ));
    });
  }

  void onTap(context,AsyncSnapshot<List<SongModel>> item){
    
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) {
                            return MusicScreen(
                              songModel: item.data!,
                             // index: index,
                            );
                          }),
                        ),
                      ).whenComplete(() {
                        notifyListeners();
                      });
  }
}
