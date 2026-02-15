/// Log levels for filtering and categorization.
enum LogType {
  /// Verbose, low level logs.
  trace,

  /// Development-level logs.
  debug,

  /// General application information.
  info,

  /// Potential issues or warnings.
  warn,

  /// Error messages and failures.
  error,

  /// Successful operation markers.
  success,
}

/// Represents a single log entry in the memory buffer.
class LogEntry {
  /// The timestamp of the log entry.
  final DateTime timestamp;

  /// The type or level of the log entry.
  final LogType type;

  /// The main log message.
  final String message;

  /// An optional error object associated with the log.
  final Object? error;

  /// An optional stack trace associated with the log.
  final StackTrace? stackTrace;

  /// Creates a new log entry.
  LogEntry({
    required this.timestamp,
    required this.type,
    required this.message,
    this.error,
    this.stackTrace,
  });

  @override
  String toString() =>
      '[${timestamp.toIso8601String()}] [${type.name.toUpperCase()}] $message';
}
