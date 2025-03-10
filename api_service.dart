import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://67cf27ef823da0212a81a556.mockapi.io/posts';
  Future<List<dynamic>> getPosts() async {
    final response = await http.get(Uri.parse(baseUrl));
    return response.statusCode == 200 ? json.decode(response.body) : [];
  }

  Future<void> addPost(String title, String body) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"title": title, "body": body}),
    );
  }

  Future<void> updatePost(String id, String title, String body) async {
    await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"title": title, "body": body}),
    );
  }

  Future<void> deletePost(String id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }
}
