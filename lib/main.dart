import 'package:flutter/material.dart';
import './login.dart';
import './home.dart';

void main() => runApp(EngineApp());

class EngineApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return EngineState();
  }
}

class EngineState extends State<EngineApp> {

  var _isLoggedIn = false;

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Builder(
        builder: (context) => this._isLoggedIn? HomeWidget() : LoginWidget()
      )
    );
  }
}