import 'package:demo/Controller/db/functions/db%20functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  final SongModel song;
  FavoriteButton({super.key, required this.song, required this.icon});
  final IconData icon;

  Color iconcolor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    onPressed(context);
    return Consumer<FavoriteDb>(
      builder: (context, value, child) {
        return IconButton(
          onPressed: () async {
            bool isfav = await value.isFav(song.id);
            
            if (!isfav) {
              value.addFav(song);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added to Favourite',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  margin:
                      const EdgeInsets.only(left: 60, right: 60, bottom: 10),
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(milliseconds: 500),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                ),
              );
            } else {
              value.removeFav(song.id);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Removed From Favourite',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  margin:
                      const EdgeInsets.only(left: 60, right: 60, bottom: 10),
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(milliseconds: 500),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                ),
              );
            }
            onPressed(context);
            
          },
          icon: Icon(
            icon,
            color: iconcolor,
          ),
          padding: const EdgeInsets.only(right: 2, left: 2, top: 2),
        );
      },
    );
  }

  void onPressed(BuildContext context) async {
    bool isfav =
        await Provider.of<FavoriteDb>(context, listen: false).isFav(song.id);
    iconcolor = isfav ? Colors.red : Colors.grey;
  }
}




