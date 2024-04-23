import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityCheck {
  static Future<bool> isConnected() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      return true;
    } else {
      return false;
    }
  }
}
