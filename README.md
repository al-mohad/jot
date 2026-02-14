# Jot

A lightweight, zero-dependency, and colored logger for Flutter & Dart.

## Features

- **🚀 Zero Dependencies**: No `get_it`, `injectable`, or complex setup.
- **🎨 Colored Output**: Easy-to-read console logs using `ansicolor`.
- **💾 Buffered Logging**: Keeps the last 500 logs in memory for debugging or crash reporting.
- **✨ JSON Pretty Printing**: Automatically formats Map and List objects for readability.
- **📤 Export Ready**: easily export logs to a string for sharing.
- **🪝 External Hooks**: Callback support for crash reporting integration (e.g., Firebase Crashlytics).

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  jot:
    path: ./ # Or git url
```

## Usage

### Initialization

Initialize Jot in your `main()` function:

```dart
void main() async {
  await Jot.init();
  runApp(MyApp());
}
```

### Logging

```dart
// Simple messages
Jot.info('App started');
Jot.warning('Memory running low');
Jot.error('API failed', error: e, stackTrace: s);
Jot.success('Data saved successfully');

// Structured data (automatically formatted)
Jot.info({
  'user': 'jdoe',
  'action': 'login',
  'metadata': {'id': 123, 'role': 'admin'}
});
```

### Exporting Logs

Get all buffered logs as a formatted string:

```dart
String report = Jot.exportLog;
// Share 'report' via email or clipboard
```

### Crashlytics Integration

// Hook into logs (e.g. for Crashlytics)
Jot.onLog = (entry) {
if (entry.type == LogType.error) {
// FirebaseCrashlytics.instance.recordError(entry.error, entry.stackTrace, reason: entry.message);
}
};

### Advanced: Custom Implementation

You can swap the default logger with your own implementation by implementing `JotLogger`:

```dart
class MyCustomLogger implements JotLogger {
  // ... implement methods
}

void main() {
  Jot.instance = MyCustomLogger();
  runApp(MyApp());
}
```
