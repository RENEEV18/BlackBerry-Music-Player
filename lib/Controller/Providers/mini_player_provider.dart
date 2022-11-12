import 'package:demo/View/widgets/musicfile.dart';
import 'package:flutter/cupertino.dart';

class MiniPlayerProvider extends ChangeNotifier{
 
  void mountedfun() async {
    MusicFile.audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        notifyListeners();
      }
    });
  }

}