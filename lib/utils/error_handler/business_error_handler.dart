import 'dart:io';

import 'package:profinder/utils/error_handler/connectivity_check.dart';
import 'package:profinder/utils/error_handler/error_payload.dart';
import 'package:profinder/utils/error_handler/exceptions/data_exception.dart';

class BusinessErrorHandler {
  static Future<ErrorPayload?> checkErrorType() async {
    bool isConnected = await ConnectivityCheck.isConnected();
    if (isConnected) {
      return ErrorPayload(ErrorType.CONNECTIVITY);
    } else {
      return ErrorPayload(ErrorType.DATA);
    }
  }

  static void handleError(ErrorPayload? errorPayload) {
    if (errorPayload != null) {
      switch (errorPayload.type) {
        case ErrorType.CONNECTIVITY:
          throw SocketException('no internet access');
        case ErrorType.DATA:
          throw DataException();
      }
    } else {
      throw Exception('Unknown error');
    }
  }
}
