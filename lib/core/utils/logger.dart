import 'package:logger/logger.dart';

/// AppLogger wraps the `logger` package to centralize formatting and log levels.
class AppLogger {
  AppLogger._();

  static final Logger _logger = Logger(
    printer: PrettyPrinter(methodCount: 2),
    level: Level.debug,
  );

  static void d(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.d(message, error, stackTrace);
  static void i(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.i(message, error, stackTrace);
  static void w(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.w(message, error, stackTrace);
  static void e(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error, stackTrace);
  static void v(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.v(message, error, stackTrace);
}
