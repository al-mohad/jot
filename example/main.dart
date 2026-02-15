import 'package:jot/jot.dart';

void main() async {
  // Initialize the logger with a custom name
  await Jot.init('MyApp');

  // Simple logging
  Jot.info('Application started');

  // Logging with different levels
  Jot.trace('This is a trace message');
  Jot.debug({
    'status': 'ok',
    'data': [1, 2, 3],
  }); // Pretty prints JSON
  Jot.warn('Low disk space');

  try {
    throw Exception('Simulated network error');
  } catch (e, stack) {
    Jot.error('Failed to fetch data', error: e, stackTrace: stack);
  }

  Jot.success('Process completed successfully');

  // Export logs
  // ignore: avoid_print
  print('\n--- Exported Logs ---\n');
  // ignore: avoid_print
  print(Jot.exportLog);

  // Clean up
  await Jot.dispose();
}
