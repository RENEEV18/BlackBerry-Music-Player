import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class Textfont1 extends StatelessWidget {
  const Textfont1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
      children: [
        TextSpan(
            text: 'W',
            style: GoogleFonts.montserrat(
              color: const Color.fromARGB(255, 241, 0, 189),
              fontSize: 35, 
              fontWeight: FontWeight.bold,
            )),
        TextSpan(
            text: 'elcome.',
            style: GoogleFonts.montserrat(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 30, 
              fontWeight: FontWeight.w500,
            ),),
      ],
    ));
  }
}

// class Textfont2 extends StatelessWidget {
//   const Textfont2({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 14,top: 4,),
//       child: Text.rich(TextSpan(
//         children: [
//           TextSpan(
//               text: 'H',
//               style: GoogleFonts.montserrat(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               )),
//           TextSpan(
//               text: 'i',
//               style: GoogleFonts.montserrat(
//                 color: Colors.white, 
//                 fontSize: 20, 
//                 fontWeight: FontWeight.bold,
//               )),
//         ],
//       )),
//     );
//   }
// }

// class Textfont3 extends StatefulWidget {
//   const Textfont3({Key? key, required this.username}) : super(key: key);
//   final String username;
//   @override
//   State<Textfont3> createState() => _Textfont3State();
// }

// class _Textfont3State extends State<Textfont3> {
  

   
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 20),
//           child: Text(
//             widget.username.toUpperCase(),

//             style: GoogleFonts.montserrat(
//               fontSize: 22,
//               color: const Color.fromARGB(255, 241, 0, 189),
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
class Textfont4 extends StatelessWidget {
  const Textfont4({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(''' Enjoy your music with more Color...
 Listen to the endless music on Blackberry !''',style: GoogleFonts.montserrat(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize: 13,
          ),),
        )
      ],
    );
  }
}
class Textfont5 extends StatelessWidget {
  const Textfont5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12,top: 4,),
      child: Text.rich(TextSpan(
        children: [
          TextSpan(
              text: 'Jump',
              style: GoogleFonts.montserrat(
                color: const Color.fromARGB(255, 241, 0, 189),
                fontSize: 26,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
              )),
          TextSpan(
              text: '\n Back In',
              style: GoogleFonts.montserrat(
                color: const Color.fromARGB(255, 255, 255, 255), 
                 letterSpacing: 1,
                fontSize: 20, 
                fontWeight: FontWeight.bold,
              )),
             
        ],
      )),
    );
  }
}

