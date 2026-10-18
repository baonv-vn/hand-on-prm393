import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:lab8_networking/services/api_service.dart';

ApiService _serviceReturning(String body, {int status = 200}) {
  final client = MockClient((_) async => http.Response(body, status));
  return ApiService(client: client);
}

void main() {
  test ('Returns posts when the server answers 200', () async {
    final api = _serviceReturning(
      '[{"userId":1, "id":1, "title":"t","body":"b"}]',
    );
    final posts = await api.fetchPosts();
    expect(posts, hasLength(1));
    expect(posts.first.title, 't');
  });

  test('returns an empty list for an empty array', () async {
    expect(await _serviceReturning('[]').fetchPosts(), isEmpty);
  });

  test('throws ApiException on a non-200 status', () async {
    await expectLater(
      _serviceReturning('{}', status: 500).fetchPosts(),
      throwsA(isA<ApiException>()),
    );
  });

  test('throws ApiException when the body is not JSON', () async {
    await expectLater(
      _serviceReturning('not json').fetchPosts(),
      throwsA(isA<ApiException>()),
    );
  });

  test('throws ApiException when the body is an object, not a list', () async {
    await expectLater(
      _serviceReturning('{"a":1}').fetchPosts(),
      throwsA(isA<ApiException>()),
    );
  });

  test('throws ApiException when an item is missing a field', () async {
    await expectLater(
      _serviceReturning('[{"id":1}]').fetchPosts(),
      throwsA(isA<ApiException>()),
    );
  });

  test('throws ApiException when the network fails', () async {
    final client = MockClient((_) async {
      throw http.ClientException('offline');
    });
    await expectLater(
      ApiService(client: client).fetchPosts(),
      throwsA(isA<ApiException>()),
    );
  });
}