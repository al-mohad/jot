import 'package:flutter_test/flutter_test.dart';
import 'package:jot/jot.dart';

void main() {
  test('Jot logger initializes and logs info', () async {
    await Jot.init();
    Jot.info('Test Info Message');
    Jot.trace('Test Trace Message');
    Jot.debug('Test Debug Message');
    Jot.warn('Test Warn Message');

    expect(Jot.logs.isNotEmpty, true);
    expect(Jot.logs.any((l) => l.message == 'Test Info Message'), true);
    expect(Jot.logs.any((l) => l.type == LogType.info), true);
    expect(Jot.logs.any((l) => l.type == LogType.trace), true);
    expect(Jot.logs.any((l) => l.type == LogType.debug), true);
    expect(Jot.logs.any((l) => l.type == LogType.warn), true);
  });

  test('Jot logger handles circular buffer', () {
    Jot.dispose(); // Clear buffer
    for (int i = 0; i < 505; i++) {
      Jot.info('Message $i');
    }

    expect(Jot.logs.length, 500);
    expect(Jot.logs.first.message, 'Message 5');
    expect(Jot.logs.last.message, 'Message 504');
  });

  test('Jot logger pretty prints JSON', () {
    Jot.dispose();
    final data = {
      'key': 'value',
      'list': [1, 2],
    };
    Jot.info(data);

    expect(
      Jot.logs.last.message,
      contains('{\n  "key": "value",\n  "list": [\n    1,\n    2\n  ]\n}'),
    );
  });

  test('Jot logger exports logs', () {
    Jot.dispose();
    Jot.info('Test log');
    final export = Jot.exportLog;
    expect(export, contains('=== JOT LOG EXPORT ==='));
    expect(export, contains('Test log'));
  });
}
