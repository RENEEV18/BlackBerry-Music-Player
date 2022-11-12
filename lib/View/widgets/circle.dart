import 'package:flutter/material.dart';

class CircleHome extends StatelessWidget {
  const CircleHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 40,
        child: Container(
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 37, 2, 61),
                  Color.fromARGB(255, 77, 0, 221),
                  Color.fromARGB(255, 241, 171, 241),
                ],
              )),
        ),
      ),
    );
  }
}
