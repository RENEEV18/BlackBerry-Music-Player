// import 'package:demo/View/screens/home.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../widgets/fonts.dart';

// class SecondScreen extends StatefulWidget {
//   const SecondScreen({Key? key}) : super(key: key);

//   @override
//   State<SecondScreen> createState() => _SecondScreenState();
// }

// class _SecondScreenState extends State<SecondScreen> {
//   final storage = const  FlutterSecureStorage();

//   TextEditingController nameController = TextEditingController();
  

//   @override
//   void initState() {
//     super.initState();
    
//   }



//   @override
//   void dispose() {
//     super.dispose();
//     nameController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
  
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 0, 0, 0),
//       body: ListView(
//         children: [
//           Container(
//             height: 350,
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(
//                     'assets/images/95988-bigthumbnail.jpg'),
//                 fit: BoxFit.cover,
//               ),
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(40),
//                 bottomRight: Radius.circular(40),
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               CircleAvatar(
//                 radius: 3,
//                 backgroundColor: Color.fromARGB(255, 255, 255, 255),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               CircleAvatar(
//                 radius: 3,
//                 backgroundColor: Color.fromARGB(255, 255, 255, 255),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.aspectRatio * 100,
//           ),
//           Row(
//             children: [
//               SizedBox(
//                 height: MediaQuery.of(context).size.aspectRatio * 100,
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.aspectRatio * 40,
//               ),
//               Stack(
//                 children: [
//                   CircleAvatar(
//                     child: Container(
//                       decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           gradient: LinearGradient(
//                             colors: [
//                               Color.fromARGB(255, 78, 0, 68),
//                               Color.fromARGB(255, 223, 6, 194),
//                               Color.fromARGB(255, 241, 171, 241),
//                             ],
//                           )),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20),
//                     child: CircleAvatar(
//                       child: Container(
//                         decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             gradient: LinearGradient(
//                               colors: [
//                                 Color.fromARGB(255, 37, 2, 61),
//                                 Color.fromARGB(255, 77, 0, 221),
//                                 Color.fromARGB(255, 241, 171, 241),
//                               ],
//                             )),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               const SizedBox(width: 10),
//               const Textfont1(),
//             ],
//           ),
//           const SizedBox(height: 10 ),
//           const Textfont4(),
//           SizedBox(
//             height: MediaQuery.of(context).size.aspectRatio * 100,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 30, right: 30),
//             child: TextFormField(
//               maxLength: 6,
//               maxLengthEnforcement: MaxLengthEnforcement.enforced,
//               controller: nameController,
//               cursorColor: const Color.fromARGB(255, 255, 255, 255),
//               style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
//               decoration: InputDecoration(
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 30),
//                 labelText: 'Name',
//                 labelStyle: GoogleFonts.montserrat(
//                     color: const Color.fromARGB(255, 255, 255, 255)),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(40),
//                   borderSide: const BorderSide(
//                     color: Color.fromARGB(255, 255, 255, 255),
//                     width: 2,
//                   ),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(
//                       color: Color.fromARGB(255, 255, 255, 255),
//                     ),
//                     borderRadius: BorderRadius.circular(40)),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.aspectRatio * 50,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 100,right: 100),
//             child: ElevatedButton.icon(onPressed:(){
//              onPressed();
//             } ,
//              icon: const Icon(Icons.arrow_forward_ios,color: Color.fromARGB(255, 0, 0, 0),),
//               label: const Text('Get Started',style: TextStyle(color: Colors.black),)),
//           )
//         ],
//       ),
//     );
//   }

// //   void onPressed() async {
// //     bool login = false;
// //     final controller = nameController.text.toString();
// //     if (controller.isNotEmpty) {
      
// //       await storage.write(key: 'username', value: controller);
// //       final value =  await storage.write(key: 'login', value: 'success');
    
// // }

// //        Navigator.of(context).pushReplacement(
// //         MaterialPageRoute(
// //           builder: ((context) {
// //             return  HomeScreen();
// //           }),
// //         ),
// //       );
      
// //     } 
    
//   }

  

