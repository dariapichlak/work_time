import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_time/sql_helper/sql_helper.dart';
import 'package:intl/intl.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Map<String, dynamic>> journals = [];
  bool orderByDateDescending = false;
  bool isLoading = true;

  TimeOfDay time = const TimeOfDay(hour: 10, minute: 30);

  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      journals = data;
      isLoading = false;
    });
  }

  DateTime dateTime = DateTime.now();
  _selectedDate(BuildContext context) async {
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now().add(
        const Duration(days: 365 * 10),
      ),
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color.fromARGB(255, 255, 102, 0),
              onPrimary: Colors.white,
              surface: Colors.black,
            ),
            dialogBackgroundColor: Colors.black),
        child: child!,
      ),
    );

    if (pickedDate != null) {
      setState(() {
        dateTime = pickedDate;
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
  }

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _worktimeController = TextEditingController();

  void _showForm(int? id) async {
    if (id != null) {
      final existingJournal =
          journals.firstWhere((element) => element['id'] == id);
      _dateController.text = existingJournal['date'];
      _worktimeController.text = existingJournal['worktime'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom + 300,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _dateController,
                    keyboardType: TextInputType.number,
                    cursorColor: const Color.fromARGB(255, 255, 102, 0),
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 102, 0),
                        ),
                      ),
                      hintText: 'Pick date',
                      prefixIcon: InkWell(
                        onTap: () {
                          _selectedDate(context);
                        },
                        child: const Icon(
                          Icons.calendar_today_outlined,
                          color: Color.fromARGB(255, 255, 102, 0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _worktimeController,
                    keyboardType: TextInputType.number,
                    cursorColor: const Color.fromARGB(255, 255, 102, 0),
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 102, 0),
                        ),
                      ),
                      hintText: 'Pick how long was work',
                      prefixIcon: InkWell(
                        onTap: () async {
                          TimeOfDay? newTime = await showTimePicker(
                            context: context,
                            initialTime: time,
                            builder: (context, child) => Theme(
                              data: ThemeData().copyWith(
                                  colorScheme: const ColorScheme.dark(
                                    primary: Colors.white,
                                    onPrimary: Color.fromARGB(255, 255, 102, 0),
                                    surface: Colors.black,
                                  ),
                                  dialogBackgroundColor: Colors.black),
                              child: child!,
                            ),
                          );
                          if (newTime == null) return;
                          setState(() {
                            time = newTime;
                          });
                          _worktimeController.text =
                              time.format(context).toString();
                        },
                        child: const Icon(
                          Icons.timelapse,
                          color: Color.fromARGB(255, 255, 102, 0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: () async {
                        if (id == null) {
                          await _addItem();
                        }
                        _dateController.text = '';
                        _worktimeController.text = '';
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Add',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      )),
                ],
              ),
            ));
  }

  Future<void> _addItem() async {
    await SQLHelper.createItem(_dateController.text, _worktimeController.text);
    _refreshJournals();
  }

  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);

    _refreshJournals();

    Navigator.pop(context, 'Yes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 65, 65, 65),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: IconButton(
            icon: const RotatedBox(
              quarterTurns: 1,
              child: Icon(
                Icons.compare_arrows,
                color: Color.fromARGB(255, 255, 102, 0),
                size: 35,
              ),
            ),
            onPressed: () {
              setState(() {
                journals = journals.reversed.toList();
              });
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 255, 102, 0),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: journals.length,
                      itemBuilder: (context, index) {
                        return Card(
                            color: Colors.black,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    color: Colors.transparent,
                                    width: 100,
                                    child: Text(
                                      journals[index]['date'],
                                      style: const TextStyle(fontSize: 18),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.transparent,
                                    width: 70,
                                    child: Text(
                                      journals[index]['worktime'],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 255, 102, 0),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        size: 22,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                                  elevation: 10,
                                                  title: const Text('Delete?',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25,
                                                      )),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, 'No'),
                                                        child: const Text(
                                                          'No',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    102,
                                                                    0),
                                                            fontSize: 20,
                                                          ),
                                                        )),
                                                    const SizedBox(
                                                      width: 65,
                                                    ),
                                                    TextButton(
                                                        onPressed: () =>
                                                            _deleteItem(
                                                                journals[index]
                                                                    ['id']),
                                                        child: const Text('Yes',
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      255,
                                                                      102,
                                                                      0),
                                                              fontSize: 20,
                                                            ))),
                                                  ],
                                                ));
                                      }),
                                ],
                              ),
                            ));
                      }),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
          size: 27,
        ),
        onPressed: () => _showForm(null),
      ),
    );
  }
}
