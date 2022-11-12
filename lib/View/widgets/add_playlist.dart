import 'package:demo/Controller/db/functions/db%20functions.dart';
import 'package:demo/Model/model/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddPlaylist extends StatelessWidget {
  const AddPlaylist({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        addPlaylist(context);
      },
      mini: true,
      backgroundColor: Colors.grey,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  void addPlaylist(context) {
    showModalBottomSheet(
      elevation: 20,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: ((context) => BottomSheet()),
    );
  }
}

class BottomSheet extends StatelessWidget {
  BottomSheet({super.key});

   static final _formKey =  GlobalKey<FormState>();  

  


  TextEditingController addButtonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Consumer<FavoriteDb>(
      builder: (context, value, child) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(30),
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: const Color.fromARGB(255, 80, 74, 74),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'New Playlist',
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          // validator: ((value1) {
                          //   if (value1!.isEmpty) {
                          //     return "Please Enter Playlist Name";
                          //   }
                          //   // final data = value.playlistModel
                          //   //     .map((e) => e.playlistname.trim())
                          //   //     .toList();
                          //   // if (data.contains(
                          //   //   addButtonController.text.trim(),
                          //   // ))
                          //   //  {
                          //   //   return 'Playlist Name Already Exists';
                          //   // }
                           
                          //   return null;
                          // }),

                          //////////////////////////////////////////////////

                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          controller: addButtonController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                )),
                            enabled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText: 'add playlist',
                            labelStyle: GoogleFonts.montserrat(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 0, 0),
                            ),
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                onPressedPlaylist(context);
                              } else {
                                return;
                              }
                              Navigator.of(context).pop();
                              addButtonController.clear();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                            ),
                            child: Text(
                              'Create',
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> onPressedPlaylist(BuildContext context) async {
    final playlist = Provider.of<FavoriteDb>(context, listen: false);
    final add = addButtonController.text.trim();
    if (add.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please add your playlist name',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          duration: const Duration(milliseconds: 500),
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        ),
      );
    } else {
      final playAdd = PlaylistSongModel(playlistname: add);
      playlist.addPlaylist(playAdd);
    }
  }
}
