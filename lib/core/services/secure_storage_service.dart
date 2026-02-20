// ignore_for_file: inference_failure_on_untyped_parameter

import 'dart:convert';

import 'package:feedback_to_vfd/core/utils/custom_log_file.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService._init();
  static final SecureStorageService instance = SecureStorageService._init();

  FlutterSecureStorage _storage = const FlutterSecureStorage();

  // ignore: avoid_setters_without_getters
  set storage(FlutterSecureStorage storage) {
    _storage = storage;
  }

  // Future<String?> getAccessToken() async {
  //   kLogs('Getting access token from secure storage');
  //   return _storage.read(key: 'access_token');
  // }

  // Future<String?> getRefreshToken() async {
  //   return _storage.read(key: 'refresh_token');
  // }

  // Future<void> saveRetrievedTokens(
  //   String accessToken,
  // ) async {
  //   await _storage.write(key: 'access_token', value: accessToken);
  //   kLogs('Tokens saved successfully');
  // }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  // Future<void> updateAccessToken(String? newUserAccessToken) async {
  //   await _storage.write(key: 'access_token', value: newUserAccessToken);
  // }

  Future<void> saveMiningCreationTime(String? data) async {
    kLogs('Data is $data');
    await _storage.write(key: 'mining_creation_time', value: data);
  }

  Future<Duration?> getTimeLeftFromMiningCreationTime() async {
    kLogs('getting time left from mining creation time');

    final creationTimeString = await _storage.read(key: 'mining_creation_time');
    if (creationTimeString == null) {
      kLogs('No mining creation time found');
      return null;
    }
    kLogs('Mining creation time is $creationTimeString');

    try {
      final creationTime = DateTime.parse(creationTimeString);
      kLogs('Creation time parsed is $creationTime');
      final expirationTime = creationTime.add(const Duration(hours: 6));
      kLogs('Expiration time is $expirationTime');
      final timeLeft = expirationTime.difference(DateTime.now());
      kLogs('Time left is $timeLeft');

      if (timeLeft.isNegative) {
        kLogs('Mining creation time has already passed');
        return Duration.zero;
      }

      return timeLeft;
    } catch (e) {
      kLogs('Error parsing mining creation time: $e');
      return null;
    }
  }

  // Future<void> saveUserData(Map<String, dynamic>? data) async {
  //   if (data == null) return;
  //   kLogs('Saving user data to secure storage');
  //   await _storage.write(key: 'user_data', value: data.toString());
  // }

  Future<void> saveUserData(Map<String, dynamic>? data) async {
    if (data == null) return;
    // kLogs('Saving user data to secure storage ======> $data');
    final jsonData = jsonEncode(data);
    await _storage.write(key: 'user_data', value: jsonData);
  }

  // Future<({Map<String, dynamic>? mapResponse, LoginResponse? modelResponse})>
  // getUserData() async {
  //   final userDataString = await _storage.read(key: 'user_data');
  //   kLogs('Got user data from secure storage');
  //   // kLogs('User data string is $userDataString');
  //   if (userDataString == null) return (mapResponse: null, modelResponse: null);
  //   try {
  //     final userData = jsonDecode(userDataString) as Map<String, dynamic>;
  //     final parsedData = LoginResponse.fromJson(userData);
  //     return (mapResponse: userData, modelResponse: parsedData);
  //   } catch (e) {
  //     kLogs('Error parsing user data: $e');
  //     return (mapResponse: null, modelResponse: null);
  //   }
  // }

  Future<void> deleteUserData() async {
    kLogs('Deleting user data from secure storage');
    await _storage.delete(key: 'user_data');
    await _storage.deleteAll();
  }

  Future<void> deleteThisKey(String s) async {
    kLogs('Deleting key $s from secure storage');
    await _storage.delete(key: s);
  }

  Future<void> savePendingSettings(String s, String string) async {
    kLogs('Saving pending settings to secure storage with key $s');
    await _storage
        .write(key: s, value: string)
        .then((_) {
          kLogs('Pending settings saved successfully');
        })
        .catchError((error) {
          kLogs('Error saving pending settings: $error');
        });
  }

  Future<Map<String, dynamic>?> getSavedSettings() async {
    final response = await _storage.read(key: 'pending_settings');
    return response == null
        ? null
        : jsonDecode(response) as Map<String, dynamic>;
  }

  Future<bool> checkThisKey(String s) async {
    kLogs('Checking if key $s exists in secure storage');
    return _storage
        .containsKey(key: s)
        .then((exists) {
          kLogs('Key $s exists: $exists');
          return exists;
        })
        .catchError((error) {
          kLogs('Error checking key $s: $error');
          return false;
        });
  }

  // Future<void> saveJwtTokens(JwtEntity jwtData) async {
  //   await _storage.write(key: 'access', value: jwtData.access);
  //   await _storage.write(key: 'refresh', value: jwtData.refresh);
  // }

  Future<void> deleteJwtTokens() async {
    await _storage.delete(key: 'access');
    await _storage.delete(key: 'refresh');
    kLogs('JWT tokens deleted successfully');
  }

  Future<String?> getAccessJwtToken() async {
    return _storage.read(key: 'access');
  }

  Future<String?> getRefreshJwtToken() async {
    return _storage.read(key: 'refresh');
  }
}
