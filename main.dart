import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/post_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PostProvider()..loadPosts(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: PostScreen());
  }
}

class PostScreen extends StatelessWidget {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('CRUD with Mock API')),
      body: provider.posts.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: provider.posts.length,
        itemBuilder: (context, index) {
          final post = provider.posts[index];
          return ListTile(
            title: Text(post['title']),
            subtitle: Text(post['body']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    titleController.text = post['title'];
                    bodyController.text = post['body'];
                    showForm(context, provider, post['id']);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => provider.deletePost(post['id']),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showForm(context, provider, null),
      ),
    );
  }

  void showForm(BuildContext context, PostProvider provider, String? id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(id == null ? 'Add Post' : 'Edit Post'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: InputDecoration(labelText: 'Title')),
            TextField(controller: bodyController, decoration: InputDecoration(labelText: 'Body')),
          ],
        ),
        actions: [
          TextButton(child: Text('Cancel'), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: Text('Save'),
            onPressed: () {
              if (id == null) {
                provider.addPost(titleController.text, bodyController.text);
              } else {
                provider.updatePost(id, titleController.text, bodyController.text);
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
