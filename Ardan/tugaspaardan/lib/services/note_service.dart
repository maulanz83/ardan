import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/note.dart';

class NoteService {
  final String baseUrl = 'https://backend2-zxe5xu6lzq-et.a.run.app/notes';

  Future<List<Note>> getNotes(String email) async {
    final response = await http.get(Uri.parse('$baseUrl/$email'));

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((model) => Note.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load notes');
    }
  }

  Future<Note> createNote(String email, String title, String content) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'title': title, 'content': content}),
    );

    if (response.statusCode == 200) {
      return Note.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create note');
    }
  }
}
