import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ParentPinStorage {
  ParentPinStorage({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  static const _pinKey = 'parent_dashboard_pin';

  final FlutterSecureStorage _storage;

  Future<String?> readPin() {
    return _storage.read(key: _pinKey);
  }

  Future<void> savePin(String pin) {
    return _storage.write(key: _pinKey, value: pin);
  }
}
