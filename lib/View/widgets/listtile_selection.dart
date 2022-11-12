import 'package:demo/Controller/Providers/playlaist_icon_provider.dart';
import 'package:demo/Controller/db/functions/db%20functions.dart';
import 'package:demo/Model/model/model.dart';
import 'package:demo/View/widgets/button_playlist.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class ListtileSelection extends StatelessWidget {
  const ListtileSelection(
      {super.key,
      required this.index,
      required this.item,
      required this.song,
      required this.foldername});
  final int index;
  final AsyncSnapshot<List<SongModel>> item;
  final SongModel song;
  final String foldername;
 
  @override
  Widget build(BuildContext context) {
    return ListTile(
          title: Text(
            item.data![index].displayNameWOExt,
            maxLines: 1,
            style: GoogleFonts.montserrat(
              fontSize: 15,
              color: const Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            " ${item.data![index].artist}",
            maxLines: 1,
            style: GoogleFonts.montserrat(
              fontSize: 13,
              color: const Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: QueryArtworkWidget(
            id: item.data![index].id,
            type: ArtworkType.AUDIO,
            keepOldArtwork: true,
            nullArtworkWidget: const CircleAvatar(
              radius: 24,
              backgroundImage:
                  AssetImage('assets/images/music-1085655_960_720.png'),
            ),
            quality: 100,
          ),
          trailing: ButtonPlaylist(
            song: song,
            foldername: foldername,
            index: index,
            length: item.data!.length,
          ),
        );
      }
    
   
  }

