import 'package:flutter/foundation.dart';

class AppLogger {
  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    debugPrint('ERROR: $message');
    if (error != null) {
      debugPrint('Error details: $error');
    }
    if (stackTrace != null) {
      debugPrint('Stack trace: $stackTrace');
    }
  }

  static void info(String message) {
    debugPrint('INFO: $message');
  }

  static void debug(String message) {
    if (kDebugMode) {
      debugPrint('DEBUG: $message');
    }
  }
}
