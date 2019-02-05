import 'package:flutter/material.dart';

void main() => runApp(EngineApp());

class EngineApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return EngineState();
  }
}

class EngineState extends State<EngineApp> {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Engine')
        ),
        body: Center(
          child: Text('Just test')
        )
      )
    );
  }
}