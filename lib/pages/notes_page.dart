import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_time/sql_helper/sql_helper.dart';

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
                    decoration: const InputDecoration(hintText: 'Date'),
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
                color: Colors.orange,
              ),
            )
          : ListView.builder(
              itemCount: _journals.length,
              itemBuilder: (context, index) => Card(
                color: Colors.black,
                margin: const EdgeInsets.all(15),
                child: ListTile(
                    title: Text(_journals[index]['date']),
                    subtitle: Text(_journals[index]['worktime']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                _deleteItem(_journals[index]['id']),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }
}
