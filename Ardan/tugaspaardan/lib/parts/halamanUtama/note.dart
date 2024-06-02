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
  Note? _editingNote;

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

  void createOrUpdateNote() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (_editingNote == null) {
          final newNote = await noteService.createNote(
            widget.email,
            _titleController.text,
            _contentController.text,
          );
          setState(() {
            notes.add(newNote);
          });
        } else {
          final updatedNote = await noteService.updateNote(
            _editingNote!.id,
            _titleController.text,
            _contentController.text,
          );
          setState(() {
            final index = notes.indexWhere((note) => note.id == _editingNote!.id);
            notes[index] = updatedNote;
          });
          _editingNote = null;
        }
        _titleController.clear();
        _contentController.clear();
      } catch (e) {
        // Handle error
        print(e.toString());
      }
    }
  }

  void deleteNote(int id) async {
    try {
      await noteService.deleteNote(id);
      setState(() {
        notes.removeWhere((note) => note.id == id);
      });
    } catch (e) {
      // Handle error
      print(e.toString());
    }
  }

  void startEditing(Note note) {
    setState(() {
      _editingNote = note;
      _titleController.text = note.title;
      _contentController.text = note.content;
    });
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
                    onPressed: createOrUpdateNote,
                    child: Text(_editingNote == null ? 'Create Note' : 'Update Note'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Title')),
                  DataColumn(label: Text('Content')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: notes.map((note) {
                  return DataRow(cells: [
                    DataCell(Text(note.title)),
                    DataCell(Text(note.content)),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => startEditing(note),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => deleteNote(note.id),
                          ),
                        ],
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
