import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:profinder/models/user/user.dart';
import 'package:profinder/models/user/user_creation_request.dart';

import '../../utils/constants.dart';

class AuthenticationService {
  final url = Constants.apiUrl;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<void> login(String email, String password) async {
    final String path = 'login';
    final response = await http.post(
      Uri.parse('$url/$path'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final String jwtToken = data['token'];
      print(response.body);
      final String userId = data['user']['user_id'];
      final String role = data['user']['role'];

      await secureStorage.write(key: 'jwtToken', value: jwtToken);
      await secureStorage.write(key: 'userId', value: userId);
      await secureStorage.write(key: 'role', value: role);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> signup(UserCreationRequest req) async {
    final String path = 'signup';
    final response = await http.post(
      Uri.parse('$url/$path'),
      body: req.toJson(),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String jwtToken = data['token'];

      await secureStorage.write(key: 'jwtToken', value: jwtToken);
    } else {
      throw Exception('Failed to signup');
    }
  }

  Future<void> logout() async {
    await secureStorage.delete(key: 'jwtToken');
  }

  Future<UserEntity> fetchUserData() async {
    final String path = 'user/getUser';
    final String jwtToken = await getJwtToken();
    final response = await http.get(
      Uri.parse('$url/$path'),
      headers: {
        'Authorization': 'Bearer $jwtToken',
        'Content-Type': 'application/json',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body)['data'];
      final user = UserEntity.fromJson(parsed);
      return user;
    } else {
      throw Exception('Failed to load user data');
    }
  }

  static Future<String> getJwtToken() async {
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final String? jwtToken = await secureStorage.read(key: 'jwtToken');
    return jwtToken ?? '';
  }

  Future<bool> checkAuth() async {
    return getJwtToken() != '' ? true : false;
  }
}
