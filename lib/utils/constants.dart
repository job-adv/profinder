import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String apiUrl = dotenv.env['API_URL']!;
  static String defaultAvatar =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/2048px-User-avatar.svg.png';
}
