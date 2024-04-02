import 'dart:convert';
import 'package:profinder/models/post.dart';
import 'package:profinder/services/data.dart';

class PostService {
  final GenericDataService<PostEntity> _genericService =
      GenericDataService<PostEntity>('post', {
    'get': 'viewall',
    'post': 'create',
  });

  Future<List<PostEntity>> fetch() async {
    return _genericService.fetch((json) => PostEntity.fromJson(json));
  }

  Future<PostEntity> post(PostEntity entity) async {
    final String body = jsonEncode(entity.toJson());
    return _genericService.post(body);
  }
}
