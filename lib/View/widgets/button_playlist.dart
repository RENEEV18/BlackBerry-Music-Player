import 'package:demo/Controller/Providers/playlaist_icon_provider.dart';
import 'package:demo/Controller/db/functions/db%20functions.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class ButtonPlaylist extends StatelessWidget {
  ButtonPlaylist({super.key, required this.song, required this.foldername, required this.index, required this.length});

  final SongModel song;
  final String foldername;
  final int index;
  final int length;

 // IconData icon = Icons.circle_outlined;
  bool onTap = false;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PlaylistIconProvider>(context,listen: false).generateBoolList(length);
    });
    return Consumer<PlaylistIconProvider>(
      builder: (context, value, child) {
        return IconButton(
          onPressed: () {
            value. buttonClick(context,song,foldername,length,index);
          },
          icon: Icon(
            value.boolList?[index]==false?Icons.circle_outlined:Icons.playlist_add_check,
            color: Colors.white,
          ),
        );
      },
    );
  }

  // void buttonClick(BuildContext context) {
  //   final provider = Provider.of<FavoriteDb>(context, listen: false);

    

  //   if (!onTap) {
    
     
  //     provider.addplaylistSongs(song, foldername);
  //     onTap = true;
   
  //   } else {
     
  //      // icon = Icons.circle_outlined;

  //     provider.removePlaylstSong(song.id, foldername);
  //     onTap = false;
      
  //   }
  // }
}
