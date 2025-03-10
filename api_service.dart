import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  // Fetch all posts
  Future<List<dynamic>> fetchPosts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load posts');
    }
  }

  // Create a new post
  Future<void> addPost(String title, String body) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"title": title, "body": body, "userId": 1}),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add post');
    }
  }

  // Update an existing post
  Future<void> updatePost(int id, String title, String body) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"id": id, "title": title, "body": body, "userId": 1}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update post');
    }
  }

  // Delete a post
  Future<void> deletePost(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete post');
    }
  }
}
