import 'package:demo/Controller/db/functions/db%20functions.dart';
import 'package:demo/View/screens/aboutus.dart';
import 'package:demo/View/screens/home.dart';
import 'package:demo/View/screens/privacy_policy.dart';
import 'package:demo/View/screens/splash_screen.dart';
import 'package:demo/View/screens/terms_condition.dart';
import 'package:demo/View/widgets/musicfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return  HomeScreen();
                }));
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color.fromARGB(255, 255, 255, 255),
              )),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        'assets/images/blueberries-svgrepo-com.svg',
                        height: 50,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'BlackBerry',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      'Version 1.0',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
              ),
              child: TextButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const AboutUs();
                      },
                    ),
                  );
                },
                icon: const Icon(
                  Icons.info_outline_rounded,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                label: Text(
                  'About Us',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                top: 10,
              ),
              child: TextButton.icon(
                onPressed: () {
                  Share.share('https://play.google.com/store/apps/details?id=in.brototype.blackberry&hl=en_US&gl=US');
                },
                icon: const Icon(
                  Icons.share,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                label: Text(
                  'Share App',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                top: 10,
              ),
              child: TextButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const Terms();
                      },
                    ),
                  );
                },
                icon: const Icon(
                  Icons.app_registration_rounded,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                label: Text(
                  'Terms & conditions',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                top: 10,
              ),
              child: TextButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const Privacy();
                      },
                    ),
                  );
                },
                icon: const Icon(
                  Icons.privacy_tip_outlined,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                label: Text(
                  'Privacy Policy',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Reset App'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const [
                                Text('Are you sure want to reset ?'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            Consumer<FavoriteDb>(
                              builder: (context, value, child) {
                                return TextButton(
                                child: const Text('Yes'),
                                onPressed: () {
                                 
                                    value.reset();
                                   
                                    MusicFile.audioPlayer.stop();
                                    
                                   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
                                     return const SplashScreen();
                                   },), (route) => false);
                                 
                                },
                              );
                              },
                            
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Reset App'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
