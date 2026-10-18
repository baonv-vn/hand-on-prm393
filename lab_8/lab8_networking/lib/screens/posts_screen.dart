import 'package:flutter/material.dart';
import 'package:lab8_networking/services/api_service.dart';

import '../models/post.dart';

class PostsScreen extends StatefulWidget {
  final ApiService api;

  const PostsScreen({super.key, required this.api});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late Future<List<Post>> _postFuture;

  void initState() {
    super.initState();
    _postFuture = widget.api.fetchPosts();
  }

  void _reload() {
    setState(() {
      _postFuture = widget.api.fetchPosts();
    });
  }

  String _messageFor(Object? error) => error is ApiException
      ? error.message
      : 'Something went wrong. Please try again.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: FutureBuilder<List<Post>>(
        future: _postFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return _ErrorView(
              message: _messageFor(snapshot.error),
              onRetry: _reload,
            );
          }
          final posts = snapshot.data ?? const <Post>[];
          if (posts.isEmpty) {
            return const Center(child: Text('No posts yet.'));
          }
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return ListTile(
                leading: CircleAvatar(child: Text('${post.id}')),
                title: Text(
                  post.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  post.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }
          );
        }
      )
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({
    required this.message,
    required this.onRetry
});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}