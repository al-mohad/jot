/// LOG levels for filtering and categorization.
enum LogType { trace, debug, info, warn, error, success }

/// Represents a single log entry in the memory buffer.
class LogEntry {
  final DateTime timestamp;
  final LogType type;
  final String message;
  final Object? error;
  final StackTrace? stackTrace;

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
