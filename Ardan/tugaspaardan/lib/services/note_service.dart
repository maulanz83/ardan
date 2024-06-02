import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/note.dart';

class NoteService {
final String baseUrl = 'https://backend2-zxe5xu6lzq-et.a.run.app/notes';
  //final String baseUrl = 'http://192.168.1.17:3000/notes';
// dah ku mau lanjut tidur dl, nanti lanjut abis bangn isya, abis  maghrib mau belanja
// btw ini dah bisa diliat peubahanya
// mungkin bisa di coba dulu di flutternya
// yg mu ganti diatas itu dah bisa ?
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

  Future<Note> updateNote(int id, String title, String content) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title, 'content': content}),
    );

    if (response.statusCode == 200) {
      return Note.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update note');
    }
  }

  Future<void> deleteNote(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete note');
    }
  }
}
