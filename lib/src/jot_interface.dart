import 'models.dart';

/// Abstract interface for a Jot logger implementation.
abstract class JotLogger {
  /// Returns an unmodifiable list of current logs.
  List<LogEntry> get logs;

  /// Returns all logs as a single formatted string for sharing/exporting.
  String get exportLog;

  /// Callback for external logging services (e.g., Crashlytics).
  void Function(LogEntry)? onLog;

  /// Initializes the logger.
  Future<void> init([String? name]);

  /// Disposes the logger resources.
  Future<void> dispose();

  /// Logs a trace message (verbose, low level).
  void trace(Object? o);

  /// Logs a debug message (development use).
  void debug(Object? o);

  /// Logs an info message.
  void info(Object? o);

  /// Logs a warning message.
  void warn(Object? o);

  /// Logs an error message.
  void error(Object? o, {Object? error, StackTrace? stackTrace});

  /// Logs a success message.
  void success(Object? o);
}
