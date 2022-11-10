import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:spro4/models/storage_item_model/storage_item.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage();

  Future<void> writeSecureData(StorageItem item) async =>
      await storage.write(key: item.key, value: item.value);

  Future<void> deleteSecureData(String key) async =>
      await storage.delete(key: key);

  Future<void> deleteAllSecureData() async => await storage.deleteAll();

  Future<String?> readSecureData(String key) async =>
      await storage.read(key: key);
}
