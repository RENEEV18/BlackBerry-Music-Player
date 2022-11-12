import 'package:demo/Controller/Providers/bottom_provider.dart';
import 'package:demo/Controller/Providers/home_permission.dart';
import 'package:demo/Controller/Providers/mini_player_provider.dart';
import 'package:demo/Controller/Providers/now_playing_provider.dart';
import 'package:demo/Controller/Providers/playlaist_icon_provider.dart';
import 'package:demo/Controller/Providers/search_provider.dart';
import 'package:demo/Controller/Providers/timer_splash_provider.dart';
import 'package:demo/Controller/db/functions/db%20functions.dart';
import 'package:demo/View/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FavoriteDb.initializeDatabase();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TimerSplash(),
        ),
         ChangeNotifierProvider(
          create: (context) => BottomProvider(),
        ),
          ChangeNotifierProvider(
          create: (context) => HomePermissionProvider(),
        ),
         ChangeNotifierProvider(
          create: (context) => FavoriteDb(),
        ),
          ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NowPlayingProvider(),
        ),
         ChangeNotifierProvider(
          create: (context) => MiniPlayerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PlaylistIconProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/images/hand-man-person-music-black-and-white-white-photography-portrait-studio-hat-darkness-clothing-black-monochrome-dj-audio-headphones-glasses-cap-photograph-eyewear-sound-hifi-mp3-listen.jpg'), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
