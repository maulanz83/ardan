import 'package:flutter/material.dart';
import '../../services/note_service.dart';
import '../../models/note.dart';

class NotePage extends StatefulWidget {
  final String email;

  NotePage({required this.email});

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final NoteService noteService = NoteService();
  List<Note> notes = [];
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  void fetchNotes() async {
    try {
      final fetchedNotes = await noteService.getNotes(widget.email);
      setState(() {
        notes = fetchedNotes;
      });
    } catch (e) {
      // Handle error
    }
  }

  void createNote() async {
    if (_formKey.currentState!.validate()) {
      try {
        final newNote = await noteService.createNote(
          widget.email,
          _titleController.text,
          _contentController.text,
        );
        setState(() {
          notes.add(newNote);
        });
        _titleController.clear();
        _contentController.clear();
      } catch (e) {
        // Handle error
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notepad'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _contentController,
                    decoration: InputDecoration(labelText: 'Content'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some content';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: createNote,
                    child: Text('Create Note'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.content),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
