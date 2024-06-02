import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: constant_identifier_names
const String LOCAL_API = "https://backend1-zxe5xu6lzq-et.a.run.app/auth";

Future<Map<String, dynamic>> registerUser(String email, String password) async {
  final response = await http.post(
    // Uri.http(LOCAL_API, '/register'),
    Uri.parse('$LOCAL_API/register'), // 'http://
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    var data = jsonDecode(response.body);
    data = data['status'] + "#" + data['message'];
    throw data;
  }
}

Future<Map<String, dynamic>> loginUser(String email, String password) async {
  final response = await http.post(
    Uri.parse('$LOCAL_API/login'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to login');
  }
}
