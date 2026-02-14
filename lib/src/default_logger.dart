import 'dart:collection';
import 'dart:convert';
import 'dart:developer' as dev;

import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/foundation.dart';

import 'jot_interface.dart';
import 'models.dart';

class DefaultJotLogger implements JotLogger {
  static final AnsiPen _tracePen = AnsiPen()..gray(level: 0.5);
  static final AnsiPen _debugPen = AnsiPen()..blue();
  static final AnsiPen _infoPen = AnsiPen()..cyan();
  static final AnsiPen _warningPen = AnsiPen()..yellow();
  static final AnsiPen _errorPen = AnsiPen()..red();
  static final AnsiPen _successPen = AnsiPen()..green();

  /// Memory-safe buffer for recent logs (Circular buffer of 500 entries).
  final _logBuffer = ListQueue<LogEntry>(500);

  /// Callback for external logging services (e.g., Crashlytics).
  @override
  void Function(LogEntry)? onLog;

  /// Returns an unmodifiable list of current logs.
  @override
  List<LogEntry> get logs => List.unmodifiable(_logBuffer);

  /// Returns all logs as a single formatted string for sharing/exporting.
  @override
  String get exportLog {
    final buffer = StringBuffer();
    buffer.writeln('=== JOT LOG EXPORT ===');
    buffer.writeln('Generated: ${DateTime.now()}');
    buffer.writeln('Total Logs: ${_logBuffer.length}');
    buffer.writeln('======================\n');

    for (final log in _logBuffer) {
      buffer.writeln(log.toString());
      if (log.error != null) buffer.writeln('ERROR: ${log.error}');
      if (log.stackTrace != null) buffer.writeln('STACK: ${log.stackTrace}');
      buffer.writeln('--------------------------------------------------');
    }

    return buffer.toString();
  }

  @override
  Future<void> init() async {
    ansiColorDisabled = kReleaseMode;
    info('🚀 Jot Logger initialized');
  }

  @override
  Future<void> dispose() async {
    info('Jot Logger disposed');
    _logBuffer.clear();
  }

  @override
  void trace(Object? o) {
    final message = _stringify(o);
    _addBuffer(LogType.trace, message);
    if (kReleaseMode) return;
    dev.log(_tracePen(message), name: 'Jot');
  }

  @override
  void debug(Object? o) {
    final message = _stringify(o);
    _addBuffer(LogType.debug, message);
    if (kReleaseMode) return;
    dev.log(_debugPen(message), name: 'Jot');
  }

  @override
  void info(Object? o) {
    final message = _stringify(o);
    _addBuffer(LogType.info, message);
    if (kReleaseMode) return;
    dev.log(_infoPen(message), name: 'Jot');
  }

  @override
  void warn(Object? o) {
    final message = _stringify(o);
    _addBuffer(LogType.warn, message);
    if (kReleaseMode) return;
    dev.log('⚠️ ${_warningPen(message)}', name: 'Jot', level: 900);
  }

  @override
  void error(Object? o, {Object? error, StackTrace? stackTrace}) {
    final message = _stringify(o);
    _addBuffer(LogType.error, message, error: error, stackTrace: stackTrace);
    if (kReleaseMode) return;
    dev.log(
      '❌ ${_errorPen(message)}',
      name: 'Jot',
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void success(Object? o) {
    final message = _stringify(o);
    _addBuffer(LogType.success, message);
    if (kReleaseMode) return;
    dev.log('✅ ${_successPen(message)}', name: 'Jot', level: 500);
  }

  void _addBuffer(
    LogType type,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (_logBuffer.length >= 500) {
      _logBuffer.removeFirst();
    }

    final entry = LogEntry(
      timestamp: DateTime.now(),
      type: type,
      message: message,
      error: error,
      stackTrace: stackTrace,
    );

    _logBuffer.add(entry);
    onLog?.call(entry);
  }

  String _stringify(Object? o) {
    if (o is Map || o is List) {
      try {
        return const JsonEncoder.withIndent('  ').convert(o);
      } catch (_) {
        return '$o';
      }
    }
    return '$o';
  }
}
