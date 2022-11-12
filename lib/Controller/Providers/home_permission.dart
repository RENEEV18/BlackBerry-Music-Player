import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePermissionProvider extends ChangeNotifier {
  final audiQuery = OnAudioQuery();
  void permissionRequest() async {
    await Permission.storage.request();
    notifyListeners();
    FocusManager.instance.primaryFocus?.unfocus();
    
  }
}
