import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:profinder/models/review/review.dart';
import 'package:profinder/models/review/review_creation_request.dart';
import 'package:profinder/services/data.dart';
import 'package:profinder/utils/constants.dart';

class ReviewService {
  final url = Constants.apiUrl;
  final GenericDataService _genericService = GenericDataService('review', {
    'post': 'add',
  });

  Future<List<Review>> fetch(int id) async {
    try {
      final FlutterSecureStorage secureStorage = FlutterSecureStorage();
      final String? jwtToken = await secureStorage.read(key: 'jwtToken');
      final uri = Uri.parse('$url/review/view/$id');
      final headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $jwtToken'
      };

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        final jsonData = parsed['data'];

        final List<Review> reviews = [];
        for (var item in jsonData) {
          final message = Review.fromJson(item);
          reviews.add(message);
        }
        return reviews;
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (error) {
      print('$error');
      throw Exception('$error');
    }
  }

  Future<Map<String, bool>> post(ReviewCreationRequest entity) async {
    final String body = jsonEncode(entity.toJson());
    return _genericService.post(body);
  }
}
