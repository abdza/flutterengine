import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './login.dart';
import './home.dart';

var serverbase = '';

final storage = new FlutterSecureStorage();

void main() => runApp(EngineApp());

class EngineApp extends StatefulWidget {
  generalsetup() async {
    serverbase = "http://10.132.1.135:8800";
    await storage.write(key: 'serverbase', value: serverbase);
  }

  EngineApp() {
    generalsetup();
  }

  @override
  State<StatefulWidget> createState() {
    return EngineState();
  }
}

class EngineState extends State<EngineApp> {
  var _isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: this._isLoggedIn ? HomeWidget() : LoginWidget());
  }
}
