import 'default_logger.dart';
import 'jot_interface.dart';
import 'models.dart';

/// A static facade for the Jot logging system.
///
/// Use [init] to initialize the logger with an optional custom name.
/// Once initialized, use the logging methods ([trace], [debug], [info], [warn], [error], [success])
/// to log messages.
class Jot {
  Jot._(); // Private constructor to prevent instantiation

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

  /// Initializes the logger. An optional [name] can be provided to identify
  /// the logger in the developer console.
  static Future<void> init([String? name]) => _instance.init(name);

  /// Disposes the logger resources and clears the log buffer.
  static Future<void> dispose() => _instance.dispose();

  /// Logs a trace message (verbose, low level).
  static void trace(Object? o) => _instance.trace(o);

  /// Logs a debug message (development use).
  static void debug(Object? o) => _instance.debug(o);

  /// Logs an info message.
  static void info(Object? o) => _instance.info(o);

  /// Logs a warning message.
  static void warn(Object? o) => _instance.warn(o);

  /// Logs an error message. An optional [error] object and [stackTrace] can be provided.
  static void error(Object? o, {Object? error, StackTrace? stackTrace}) =>
      _instance.error(o, error: error, stackTrace: stackTrace);

  /// Logs a success message.
  static void success(Object? o) => _instance.success(o);
}
