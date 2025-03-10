import 'package:flutter/material.dart';
import 'api_service.dart';

class PostProvider with ChangeNotifier {
  final ApiService apiService = ApiService();
  List<dynamic> posts = [];

  Future<void> loadPosts() async {
    posts = await apiService.getPosts();
    notifyListeners();
  }

  Future<void> addPost(String title, String body) async {
    await apiService.addPost(title, body);
    loadPosts();
  }

  Future<void> updatePost(String id, String title, String body) async {
    await apiService.updatePost(id, title, body);
    loadPosts();
  }

  Future<void> deletePost(String id) async {
    await apiService.deletePost(id);
    loadPosts();
  }
}
