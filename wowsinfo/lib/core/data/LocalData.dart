import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

/// The parent of all local data manager that wraps `Hive`
abstract class LocalData {
  Box box;
  Future init();
  Future close() => this.box.close();
  debug() {
    if (kDebugMode) this.box.keys.forEach((key) => print('$key - ${box.get(key)}'));
  }
}
