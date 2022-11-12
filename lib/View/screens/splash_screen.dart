import 'package:demo/Controller/Providers/timer_splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<TimerSplash>(context).timeSplash(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: const [
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 0, 0, 0),
                      radius: 40,
                      child: Icon(
                        Icons.music_note,
                        color: Colors.white,
                        size: 50,
                      ),
                    )
                  ],
                ),
                const Text('BlackBerry',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    )),
                Text(
                  'Burry your music with more \n sweet',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: const Color.fromARGB(179, 255, 255, 255),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 0, 0, 0),
                      radius: 40,
                      child: Icon(
                        Icons.music_note,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


 // @override
  // void initState() {
  //   super.initState();
  //   Timer(const Duration(seconds: 3), () {
  //     checkLogin();
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) {
  //           return widget.isLogedIn ? const HomeScreen() : const SecondScreen();
  //         },
  //       ),
  //     );
  //   });
  // }
