import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {

  final GetStorage _box = GetStorage();
  final _key = 'isDarkMode';

   _saveThemToBox(bool isDrkMode){
     _box.write(_key, isDrkMode);
  }
  bool _loadThemFormBox(){
    return _box.read<bool>(_key)?? false;
  }
  ThemeMode get theme => _loadThemFormBox()?ThemeMode.dark :ThemeMode.light;

  void switchTheme(){
    Get.changeThemeMode(_loadThemFormBox()?ThemeMode.light:ThemeMode.dark );
    _saveThemToBox(!_loadThemFormBox());
  }
}
