import 'package:flutter_test/flutter_test.dart';
import 'package:lab8_networking/models/post.dart';

void main() {
  test('fromJson maps every field', () {
    final post = Post.fromJson({
      'userId': 1,
      'id': 2,
      'title': 'a title',
      'body': 'a body'
    });
    expect(post.userId, 1);
    expect(post.id, 2);
    expect(post.title, 'a title');
    expect(post.body, 'a body');
  });

  test('fromJson throws when a required field is missing', () {
    expect(() => Post.fromJson({'id': 1}), throwsA(isA<TypeError>()));
  });

  test('fromJson throws when a field has the wrong type', () {
    expect(
        () => Post.fromJson({'userId': 1, 'id': 'two', 'title': 't', 'body': 'b'}),
      throwsA(isA<TypeError>()),
    );
  });
}