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

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await _client
          .get(Uri.parse('$_baseUrl/posts'))
          .timeout(_timeout);

      if (response.statusCode != 200) {
        throw ApiException(
          'The server returned an error (HTTP ${response.statusCode}).',
        );
      }

      final decoded = json.decode(response.body) as List<dynamic>;
      return decoded
          .map((item) => Post.fromJson(item as Map<String, dynamic>))
          .toList();
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