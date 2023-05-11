import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TimerPage extends StatefulWidget {
  const TimerPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  Duration duration = const Duration();
  Timer? timer;
  bool isCountdown = false;
  static const countdownDuration = Duration(seconds: 10);

  @override
  void initState() {
    super.initState();

    reset();
  }

  void reset() {
    if (isCountdown) {
      setState(() {
        duration = countdownDuration;
      });
    } else {
      setState(() {
        duration = const Duration();
      });
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      addTime();
    });
  }

  void addTime() {
    setState(() {
      final seconds = duration.inSeconds + 1;
      duration = Duration(seconds: seconds);
    });
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() {
      timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final hours = twoDigits(duration.inHours);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: IconButton(
            icon: const Icon(
              Icons.restart_alt_outlined,
              color: Color.fromARGB(255, 255, 102, 0),
              size: 35,
            ),
            onPressed: () {
              stopTimer();
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 15.0,
            ),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.save_alt_outlined,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(255, 41, 41, 41),
                      blurRadius: 25,
                      spreadRadius: 5,
                      offset: Offset(15, 15)),
                ],
                borderRadius: BorderRadius.circular(130),
              ),
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 33, 33, 33),
                    Color.fromARGB(255, 86, 86, 86)
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 91, 91, 91),
                      blurRadius: 25,
                      spreadRadius: 5,
                      offset: Offset(-15, -15),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(130),
                ),
                child: Center(
                  child: Container(
                    width: 240,
                    height: 240,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(120),
                    ),
                    child: Center(
                      child: Text(
                        '$hours:$minutes:$seconds',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: buttonStartStop(),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget buttonStartStop() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;

    return isRunning || !isCompleted
        ? InkWell(
            onTap: () {
              if (isRunning) {
                stopTimer(resets: false);
              } else {
                startTimer();
              }
            },
            child: BottomTime(isRunning ? 'STOP' : 'START'))
        : InkWell(
            onTap: () {
              startTimer();
            },
            child: const BottomTime('START'));
  }
}

class BottomTime extends StatelessWidget {
  const BottomTime(
    this.textTime, {
    Key? key,
  }) : super(key: key);

  final String textTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.black,
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 41, 41, 41),
                    blurRadius: 25,
                    spreadRadius: 5,
                    offset: Offset(15, 15)),
              ],
              borderRadius: BorderRadius.circular(50),
            ),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Color.fromARGB(255, 33, 33, 33),
                  Color.fromARGB(255, 86, 86, 86)
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 91, 91, 91),
                    blurRadius: 25,
                    spreadRadius: 5,
                    offset: Offset(-15, -15),
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: Center(
                    child: Text(textTime,
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 20,
                        )),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
