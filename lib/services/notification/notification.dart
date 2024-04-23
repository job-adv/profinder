import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:profinder/models/notification/notification.dart';
import 'package:profinder/models/notification/notification_creation_request.dart';
import 'package:profinder/services/data.dart';
import 'package:http/http.dart' as http;
import 'package:profinder/utils/constants.dart';

class NotificationService {
  final url = Constants.apiUrl;
  final GenericDataService _genericService =
      GenericDataService('notification', {
    'post': 'add',
  });

  Future<Map<String, bool>> post(NotificationCreationRequest entity) async {
    final String body = jsonEncode(entity.toJson());
    return _genericService.post(body);
  }

  Future<List<NotificationEntity>> fetch() async {
    try {
      final FlutterSecureStorage secureStorage = FlutterSecureStorage();
      final String? jwtToken = await secureStorage.read(key: 'jwtToken');
      final uri = Uri.parse('$url/notification/view');
      final headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $jwtToken'
      };

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        final jsonData = parsed['data'];
        print(jsonData);

        final List<NotificationEntity> messages = [];
        for (var item in jsonData) {
          final message = NotificationEntity.fromJson(item);
          messages.add(message);
        }
        print(jsonEncode(messages));
        return messages;
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (error) {
      print('$error');
      throw Exception('$error');
    }
  }
}
