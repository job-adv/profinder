import 'dart:convert';
import 'package:profinder/models/favorite/favorite_creation_request.dart';
import 'package:profinder/services/data.dart';
import 'package:http/http.dart' as http;
import 'package:profinder/services/user/authentication.dart';
import 'package:profinder/utils/constants.dart';

class FavoriteService {
  final apiUrl = Constants.apiUrl;
  final GenericDataService<FavoriteCreationRequest> _genericService =
      GenericDataService<FavoriteCreationRequest>('favorite', {
    'post': 'add',
  });

  Future<Map<String, bool>> post(FavoriteCreationRequest entity) async {
    final String body = jsonEncode(entity.toJson());
    return _genericService.post(body);
  }

  Future<Map<String, bool>> deleteById(int favoriteId) async {
    final url = Uri.parse('$apiUrl/favorite/delete/$favoriteId');
    final String jwtToken = await AuthenticationService.getJwtToken();
    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return {'success': true};
      } else {
        throw Exception('Failed to delete favorite with ID: $favoriteId');
      }
    } catch (e) {
      throw Exception('Failed to delete favorite: $e');
    }
  }
}
