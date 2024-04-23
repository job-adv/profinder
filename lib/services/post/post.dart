import 'dart:convert';
import 'package:profinder/models/post/post.dart';
import 'package:profinder/models/post/post_creation_request.dart';
import 'package:profinder/models/post/post_update_request.dart';
import 'package:profinder/models/post/user_post.dart';
import 'package:profinder/services/data.dart';
import 'package:http/http.dart' as http;
import 'package:profinder/services/user/authentication.dart';
import 'package:profinder/utils/constants.dart';
import 'package:profinder/utils/error_handler/business_error_handler.dart';
import 'package:profinder/utils/error_handler/error_payload.dart';

class PostService {
  final apiUrl = Constants.apiUrl;
  final GenericDataService<PostEntity> _genericService =
      GenericDataService<PostEntity>('post', {
    'get': 'viewall',
    'post': 'add',
  });

  final GenericDataService<OwnPostEntity> _genericServiceUser =
      GenericDataService<OwnPostEntity>('post', {
    'get': 'viewMyPost',
  });

  Future<List<PostEntity>> fetch() async {
    return _genericService.fetch((json) => PostEntity.fromJson(json));
  }

  Future<List<OwnPostEntity>> fetchUserPosts() async {
    return _genericServiceUser.fetch((json) => OwnPostEntity.fromJson(json));
  }

  /*Future<Map<String, bool>> edit(PostUpdateRequest entity) async {
    return _genericServiceUser.patch((json) => PostUpdateRequest.fromJson(json));
  }*/

  Future<Map<String, bool>> setToComplete(
      Map<String, String> body, int id) async {
    final String? jwtToken = await AuthenticationService.getJwtToken();
    print('$apiUrl/post/update/$id');
    final response = await http.patch(
      Uri.parse('$apiUrl/post/update/$id'),
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return {'success': true};
    } else {
      ErrorPayload? errorPayload = await BusinessErrorHandler.checkErrorType();
      BusinessErrorHandler.handleError(errorPayload);

      throw Exception('Request failed with status ${response.statusCode}');
    }
  }

  Future<Map<String, bool>> updatePost(PostUpdateRequest body, int id) async {
    final String? jwtToken = await AuthenticationService.getJwtToken();
    print('$apiUrl/post/update/$id');
    final response = await http.patch(
      Uri.parse('$apiUrl/post/update/$id'),
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      body: body.toJson(),
    );

    if (response.statusCode == 200) {
      return {'success': true};
    } else {
      ErrorPayload? errorPayload = await BusinessErrorHandler.checkErrorType();
      BusinessErrorHandler.handleError(errorPayload);

      throw Exception('Request failed with status ${response.statusCode}');
    }
  }

  Future<Map<String, bool>> post(PostCreationRequest entity) async {
    final String body = jsonEncode(entity.toJson());
    return _genericService.post(body);
  }
}
