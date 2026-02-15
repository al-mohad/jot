## 1.0.0

- +- **BREAKING**: `Jot.init()` now accepts an optional `name` parameter.
  +- Add support for custom logger names in initialization.
  +- Add comprehensive documentation for the public API.
  +- Add `example` directory with a functional usage demonstration.
  +- Improve `pubspec.yaml` metadata (description, project links).
  +- Organize code with regions for better IDE folding.
- +## 0.0.1

* Initial release of Jot logger.
* Add `Jot` class for static logging.
* Implement colored console output using `ansicolor`.
* Add circular buffer for recent logs.
* Add JSON pretty printing for Map/List objects.
* Add `exportLog` getter for sharing logs.
* Add `onLog` callback for external integrations.
