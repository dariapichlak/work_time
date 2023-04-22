import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 65, 65, 65),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.circle,
            color: Colors.transparent,
            size: 30,
          ),
          onPressed: () {},
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 15.0,
            ),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.restart_alt_outlined,
                  color: Colors.transparent,
                  size: 35,
                )),
          )
        ],
        title: Center(
          child: Text(
            'YOUR WORK TIME',
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 204, 204, 204),
              fontSize: 15,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 65, 65, 65),
      body: Column(),
    );
  }
}
