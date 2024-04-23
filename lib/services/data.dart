import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:profinder/services/user/authentication.dart';
import 'package:profinder/utils/constants.dart';
import 'package:profinder/utils/error_handler/business_error_handler.dart';
import 'package:profinder/utils/error_handler/error_payload.dart';

class GenericDataService<T> {
  final url = Constants.apiUrl;
  final serviceEntityName;
  final Map<String, String> endpoints;

  GenericDataService(this.serviceEntityName, this.endpoints);

  Future<List<T>> fetch(T Function(Map<String, dynamic>) fromJson) async {
    final String? jwtToken = await AuthenticationService.getJwtToken();
    final response = await http.get(
      Uri.parse(_urlBuilder('get')),
      headers: {
        'Authorization': 'Bearer $jwtToken',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      final List<T> items = (parsed['data'] as List<dynamic>).map((itemJson) {
        return fromJson(itemJson);
      }).toList();
      return items;
    } else {
      ErrorPayload? errorPayload = await BusinessErrorHandler.checkErrorType();
      BusinessErrorHandler.handleError(errorPayload);

      throw Exception('Request failed with status ${response.statusCode}');
    }
  }

  Future<Map<String, bool>> post(String body) async {
    final String? jwtToken = await AuthenticationService.getJwtToken();
    final response = await http.post(
      Uri.parse(_urlBuilder('post')),
      headers: {
        'Authorization': 'Bearer $jwtToken',
        'Content-Type': 'application/json',
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

  Future<Map<String, bool>> patch(String body) async {
    final String? jwtToken = await AuthenticationService.getJwtToken();
    final response = await http.patch(
      Uri.parse(_urlBuilder('patch')),
      headers: {
        'Authorization': 'Bearer $jwtToken',
        'Content-Type': 'application/json',
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

  String _urlBuilder(String method) {
    String? endpoint = endpoints[method];
    return '$url/$serviceEntityName/$endpoint';
  }
}
