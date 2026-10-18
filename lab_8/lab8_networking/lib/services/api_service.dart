import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class ApiException implements Exception {
  final String message;

  const ApiException(this.message);

  @override
  String toString() => 'ApiException: $message';
}

class ApiService {
  final http.Client _client;
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const Duration _timeout = Duration(seconds: 10);

  Future<List<Post>> fetchPosts() {
    return _guard(() async {
      final response = await _client.get(Uri.parse('$_baseUrl/posts'));
      _ensureStatus(response, 200);
      final decoded = json.decode(response.body) as List<dynamic>;
      return decoded
          .map((item) => Post.fromJson(item as Map<String, dynamic>))
          .toList();
    });
  }

  Future<Post> createPost({required String title, required String body}) {
    return _guard(() async {
      final response = await _client.post(
        Uri.parse('$_baseUrl/posts'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({'title': title, 'body': body, 'userId': 1}),
      );
      _ensureStatus(response, 201);

      return Post.fromJson(json.decode(response.body) as Map<String, dynamic>);
    });
  }

  void _ensureStatus(http.Response response, int expected) {
    if (response.statusCode != expected) {
      throw ApiException(
        'The server returned an error (HTTP ${response.statusCode}).',
      );
    }
  }

  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request().timeout(_timeout);
    } on ApiException {
      rethrow;
    } on TimeoutException {
      throw const ApiException('The request time out. Please try again');
    } on http.ClientException {
      throw const ApiException('Cannot reach the server. Check your internet connection.');
    } on FormatException {
      throw const ApiException('Received unexpected data from the server.');
    } on TypeError {
      throw const ApiException('Received unexpected data from the server.');
    }
  }
}