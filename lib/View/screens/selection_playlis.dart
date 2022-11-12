
import 'package:demo/View/widgets/listtile_selection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key, required this.foldername}) : super(key: key);
  final String foldername;
  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {




  final audiQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              IconButton(onPressed: (){
                Navigator.of(context).pop();
              }, icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Color.fromARGB(255, 255, 255, 255),
                size: 30,
              ),),
         
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Center(
                    child: Text(
                      'All Songs',
                      style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color:  const Color.fromARGB(255, 241, 0, 189),),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.graphic_eq_rounded,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const [
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: FutureBuilder<List<SongModel>>(
                  future: audiQuery.querySongs(
                    sortType: null,
                    orderType: OrderType.ASC_OR_SMALLER,
                    uriType: UriType.EXTERNAL,
                    ignoreCase: true,
                  ),
                  builder: (context, item) {
                    if (item.connectionState == ConnectionState.waiting) {
                      return LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.blue, size: 40);
                    } else if (item.data!.isEmpty) {
                      return const Center(
                        child: Text(
                          'No Songs Found',
                        ),
                      );
                    } else {
                      return ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListtileSelection(
                            index: index,
                            item: item,
                            song: item.data![index],
                            foldername: widget.foldername,
                          );
                        },
                        itemCount: item.data!.length,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
