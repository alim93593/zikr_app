import 'package:flutter/foundation.dart';

enum LogLevel {
  debug,
  info,
  warning,
  error,
}

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  factory AppLogger() => _instance;
  AppLogger._internal();

  bool _isEnabled = true;

  void enable() => _isEnabled = true;
  void disable() => _isEnabled = false;

  void log(LogLevel level, String message, {String? tag, dynamic data}) {
    if (!_isEnabled) return;

    final timestamp = DateTime.now().toIso8601String();
    final tagStr = tag != null ? '[$tag]' : '';
    final levelStr = '[${level.name.toUpperCase()}]';
    final dataStr = data != null ? '\nData: $data' : '';

    final logMessage = '$timestamp $levelStr $tagStr $message$dataStr';

    switch (level) {
      case LogLevel.debug:
        debugPrint(logMessage);
        break;
      case LogLevel.info:
        debugPrint('\x1b[34m$logMessage\x1b[0m');
        break;
      case LogLevel.warning:
        debugPrint('\x1b[33m$logMessage\x1b[0m');
        break;
      case LogLevel.error:
        debugPrint('\x1b[31m$logMessage\x1b[0m');
        break;
    }
  }

  void d(String message, {String? tag, dynamic data}) => log(LogLevel.debug, message, tag: tag, data: data);
  void i(String message, {String? tag, dynamic data}) => log(LogLevel.info, message, tag: tag, data: data);
  void w(String message, {String? tag, dynamic data}) => log(LogLevel.warning, message, tag: tag, data: data);
  void e(String message, {String? tag, dynamic data}) => log(LogLevel.error, message, tag: tag, data: data);

  void logFunction(String functionName, {Map<String, dynamic>? params, dynamic result, String? error}) {
    if (error != null) {
      e('❌ $functionName', tag: 'FN', data: {'error': error, 'params': params});
    } else {
      i('✅ $functionName', tag: 'FN', data: {'result': result, 'params': params});
    }
  }

  void logNavigation(String from, String to) => i('🔄 Navigation: $from ➡️ $to', tag: 'NAV');

  void logState(String state, {String? cubit, dynamic data}) => d('📊 State: $state', tag: cubit ?? 'STATE', data: data);

  void logApi(String endpoint, {Map<String, dynamic>? params, dynamic result, String? error}) {
    if (error != null) {
      e('❌ API: $endpoint', tag: 'API', data: {'error': error, 'params': params});
    } else {
      i('📡 API: $endpoint', tag: 'API', data: {'result': result, 'params': params});
    }
  }
}

final logger = AppLogger();