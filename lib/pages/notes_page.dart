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
  // All journals
  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  DateTime _dateTime = DateTime.now();
  _selectedDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now().add(
        const Duration(days: 365 * 10),
      ),
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.orange,
              onPrimary: Colors.white,
              surface: Colors.black,
            ),
            dialogBackgroundColor: Colors.black),
        child: child!,
      ),
    );

    if (_pickedDate != null) {
      setState(() {
        _dateTime = _pickedDate;
        _dateController.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _worktimeController = TextEditingController();

  void _showForm(int? id) async {
    if (id != null) {
      final existingJournal =
          _journals.firstWhere((element) => element['id'] == id);
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
                    decoration: InputDecoration(
                      hintText: 'Date',
                      prefixIcon: InkWell(
                        onTap: () {
                          _selectedDate(context);
                        },
                        child: const Icon(Icons.calendar_today_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _worktimeController,
                    decoration: const InputDecoration(hintText: 'Work time'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () async {
                      if (id == null) {
                        await _addItem();
                      }
                      _dateController.text = '';
                      _worktimeController.text = '';
                      Navigator.of(context).pop();
                    },
                    child: const Text('Create New'),
                  )
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 255, 102, 0),
              ),
            )
          : ListView.builder(
              itemCount: _journals.length,
              itemBuilder: (context, index) => Card(
                  color: Colors.black,
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _journals[index]['date'],
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          _journals[index]['worktime'],
                          style:
                              const TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                        IconButton(
                            icon: const Icon(
                              Icons.delete,
                              size: 22,
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
                                                  Navigator.pop(context, 'No'),
                                              child: const Text(
                                                'No',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 102, 0),
                                                  fontSize: 20,
                                                ),
                                              )),
                                          const SizedBox(
                                            width: 65,
                                          ),
                                          TextButton(
                                              onPressed: () => _deleteItem(
                                                  _journals[index]['id']),
                                              child: const Text('Yes',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 255, 102, 0),
                                                    fontSize: 20,
                                                  ))),
                                        ],
                                      ));
                            }),
                      ],
                    ),
                  )),
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
