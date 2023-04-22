import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({
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
                  color: Color.fromARGB(255, 255, 102, 0),
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
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 240,
                      height: 240,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(120),
                      ),
                      child: const Center(
                        child: Text(
                          '00:00',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 70,
                          ),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(onTap: () {}, child: const BottomTime('START')),
                InkWell(onTap: () {}, child: const BottomTime('STOP')),
              ],
            ),
          ),
        ],
      ),
    );
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
