import 'package:flutter/material.dart';
import 'package:work_time/pages/notes_page.dart';
import 'package:work_time/pages/timer_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        if (index == 0) {
          return const Center(
            child: TimerPage(),
          );
        }
        return const NotesPage();
      }),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 255, 102, 0),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.timelapse_outlined,
              size: 35,
              color: Colors.black,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.note,
              size: 35,
              color: Colors.black,
            ),
            label: '',
          ),
        ],
        currentIndex: index,
        onTap: (index) {
          setState(() {
            this.index = index;
          });
        },
      ),
    );
  }
}
