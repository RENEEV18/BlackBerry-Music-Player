import 'package:demo/Controller/Providers/bottom_provider.dart';
import 'package:demo/View/screens/mini_player.dart';
import 'package:demo/View/screens/playlist.dart';
import 'package:demo/View/screens/search.dart';
import 'package:demo/View/widgets/musicfile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'favourite.dart';
import 'music_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  int currentIndex = 0;

  static List<Widget> screens = [
    ThirdScreen(),
    FavouriteScreen(),
    SearchScreen(),
    const PlaylistScreen(),
  ];

  List<BarItem> iconLst = [
   
    BarItem(
      icon: Icons.home_filled,
      title: 'Home',
    ),
    BarItem(
      icon: Icons.favorite_outlined,
      title: 'Favourite',
    ),
    BarItem(
      icon: Icons.search,
      title: 'Search',
    ),
    BarItem(
      icon: Icons.queue_music,
      title: 'Playlist',
    ),
  ];
  @override
  Widget build(BuildContext context) {
   //final provider = Provider.of<BottomProvider>(context);
    return Scaffold(
      body: Consumer<BottomProvider>(
        builder: (context, value, child) {
          return screens[value.currentIndex];
        },
      ),
      bottomNavigationBar: Consumer<BottomProvider>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            physics: const ScrollPhysics(),
            
            child: Column(
              children: [
                if (MusicFile.audioPlayer.currentIndex != null)
                  Column(
                    
                    children: const [
                     
                      MiniplayerScreen(),
                      
                      SizedBox(),
                    ],
                  )
                else
                  const SizedBox(),
                
                SlidingClippedNavBar(
                  backgroundColor: Colors.black,
                  barItems: iconLst,
                  selectedIndex: value.currentIndex,
                  onButtonPressed: (index) {
                    currentIndex = index;
                    value.currentIndex = currentIndex;
                  },
                  inactiveColor: Colors.white,
                  activeColor: const Color.fromARGB(255, 241, 0, 189),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
