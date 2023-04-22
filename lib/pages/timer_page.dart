import 'package:flutter/material.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            '00:00',
            style: TextStyle(color: Colors.white, fontSize: 80),
          ),
        ));
  }
}
