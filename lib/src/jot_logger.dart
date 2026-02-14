import 'default_logger.dart';
import 'jot_interface.dart';
import 'models.dart';

class Jot {
  static JotLogger _instance = DefaultJotLogger();

  /// Sets a custom logger implementation.
  static set instance(JotLogger logger) => _instance = logger;

  /// Returns an unmodifiable list of current logs.
  static List<LogEntry> get logs => _instance.logs;

  /// Returns all logs as a single formatted string for sharing/exporting.
  static String get exportLog => _instance.exportLog;

  /// Callback for external logging services (e.g., Crashlytics).
  static set onLog(void Function(LogEntry)? callback) =>
      _instance.onLog = callback;

  static Future<void> init() => _instance.init();

  static Future<void> dispose() => _instance.dispose();

  static void trace(Object? o) => _instance.trace(o);

  static void debug(Object? o) => _instance.debug(o);

  static void info(Object? o) => _instance.info(o);

  static void warn(Object? o) => _instance.warn(o);

  static void error(Object? o, {Object? error, StackTrace? stackTrace}) =>
      _instance.error(o, error: error, stackTrace: stackTrace);

  static void success(Object? o) => _instance.success(o);
}
