import 'package:flutter/material.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            'Notes',
            style: TextStyle(color: Colors.white, fontSize: 80),
          ),
        ));
  }
}
