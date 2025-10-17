import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'storage_service.dart';

final class SharedPreferencesStorage<T> implements StorageService<T> {
  final T Function(dynamic json)? fromJson;
  final dynamic Function(T value)? toJson;

  SharedPreferencesStorage({this.fromJson, this.toJson});

  SharedPreferences? _prefs;

  Future<void> _ensureInit() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  @override
  Future<void> init() async {
    await _ensureInit();
  }

  @override
  Future<void> clear() async {
    await _ensureInit();
    await _prefs!.clear();
  }

  @override
  Future<bool> remove(String key) async {
    await _ensureInit();
    return _prefs!.remove(key);
  }

  @override
  Future<void> set(String key, T data) async {
    await _ensureInit();

    if (toJson != null) {
      final encodedData = jsonEncode(toJson!(data));
      await _prefs!.setString(key, encodedData);
      return;
    }

    if (data is String) {
      await _prefs!.setString(key, data);
    } else if (data is int) {
      await _prefs!.setInt(key, data);
    } else if (data is double) {
      await _prefs!.setDouble(key, data);
    } else if (data is bool) {
      await _prefs!.setBool(key, data);
    } else if (data is List<String>) {
      await _prefs!.setStringList(key, data);
    } else {
      throw UnsupportedError(
        'Unsupported data type: ${data.runtimeType}. Provide a toJson function for custom types.',
      );
    }
  }

  @override
  Future<T?> get(String key, {T? defaultValue}) async {
    await _ensureInit();
    final value = _prefs!.get(key);
    if (value == null) return defaultValue;
    return fromJson != null ? fromJson!(value) : value as T?;
  }

  @override
  Future<bool> has(String key) async {
    await _ensureInit();
    return _prefs!.containsKey(key);
  }
}
