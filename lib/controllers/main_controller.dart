import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  String sessionid = '';
  static const storage = FlutterSecureStorage();
  @override
  void onInit() {
    getSessionId().then((value) {
      if(value.isNotEmpty){
        sessionid = value;
        update();
        super.onInit();
      }else{
        String cahracters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_';
        String id = '';
        for (var i = 0; i < 10; i++) {
          id += cahracters[Random().nextInt(62)];
        }
        setSessionId(id).then((value) {
          sessionid = id;
          update();
          super.onInit();
        });
      }
    });
  }

  void refresh(){
    update();
  }

  Future<String> getSessionId()async {
    String id = await storage.read(key: "id") ?? '';
    return id ;
  }

  Future<void> setSessionId(String id) async {
    await storage.write(key: "id", value: id);
  }
}