import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:profinder/models/message/message.dart';
import 'package:http/http.dart' as http;
import 'package:profinder/utils/constants.dart';

class MessageService {
  final url = Constants.apiUrl;

  Future<List<Message>> fetch(String otheruser) async {
    try {
      final FlutterSecureStorage secureStorage = FlutterSecureStorage();
      final String? jwtToken = await secureStorage.read(key: 'jwtToken');
      final uri = Uri.parse('$url/message?otheruser=$otheruser');
      final headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $jwtToken'
      };

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        final jsonData = parsed['data'];

        final List<Message> messages = [];
        for (var item in jsonData) {
          final message = Message.fromJson(item);
          messages.add(message);
        }
        print(jsonEncode(messages));
        return messages;
      } else {
        throw Exception('Failed to load messages: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching messages: $error');
      throw Exception('Failed to load messages: $error');
    }
  }

  Future<void> post(Map<String, dynamic> messageData) async {
    try {
      final FlutterSecureStorage secureStorage = FlutterSecureStorage();
      final String? jwtToken = await secureStorage.read(key: 'jwtToken');
      final uri = Uri.parse('$url/message/');
      final headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $jwtToken'
      };

      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(messageData),
      );

      if (response.statusCode == 200) {
        print('Message sent successfully');
      } else {
        throw Exception('Failed to send message: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending message: $error');
      throw Exception('Failed to send message: $error');
    }
  }
}
