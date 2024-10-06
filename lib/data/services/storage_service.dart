import 'package:get_storage/get_storage.dart';

class StorageService {
  final box = GetStorage();
  dynamic getValue(String key) {
    return box.read(key);
  }
  void setValue(String key, dynamic data){
    box.write(key, data);
  }
}
