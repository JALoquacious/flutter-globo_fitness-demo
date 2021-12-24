import 'package:flutter/material.dart';
import '../data/sp_helper.dart';
import '../data/session.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({Key? key}) : super(key: key);

  @override
  _SessionsScreenState createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtDuration = TextEditingController();
  final SPHelper spHelper = SPHelper();
  List<Session> sessions = [];

  @override
  void initState() {
    spHelper.init().then((value) {
      updateScreen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Training Sessions')),
      body: ListView(children: getContent()),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showSessionDialog(context);
        },
      ),
    );
  }

  Future<dynamic> showSessionDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Insert Training Session'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: txtDescription,
                    decoration: const InputDecoration(hintText: 'Description'),
                  ),
                  TextField(
                    controller: txtDuration,
                    decoration: const InputDecoration(hintText: 'Duration'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                    txtDescription.text = '';
                    txtDuration.text = '';
                  }),
              ElevatedButton(
                child: const Text('Save'),
                onPressed: saveSession,
              )
            ],
          );
        });
  }

  Future saveSession() async {
    DateTime now = DateTime.now();
    String today = '${now.year}-${now.month}-${now.day}';
    int id = spHelper.getCounter() + 1;
    Session newSession = Session(
      id,
      int.tryParse(txtDuration.text) ?? 0,
      today,
      txtDescription.text,
    );

    spHelper.writeSession(newSession).then((_) {
      updateScreen();
      spHelper.setCounter();
    });
    txtDescription.text = '';
    txtDuration.text = '';
    Navigator.pop(context);
  }

  List<Widget> getContent() {
    List<Widget> tiles = [];
    sessions.forEach((Session session) {
      tiles.add(ListTile(
          title: Text(session.description),
          subtitle:
              Text('${session.date} - duration: ${session.duration} min')));
    });
    return tiles;
  }

  void updateScreen() {
    sessions = spHelper.getSessions();
    setState(() {});
  }
}
