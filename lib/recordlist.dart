import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './recordview.dart';

var serverbase = '';

final storage = new FlutterSecureStorage();

class RecordListWidget extends StatefulWidget {
  generalsetup() async {
    serverbase = await storage.read(key: 'serverbase');
  }

  RecordListWidget() {
    generalsetup();
  }

  @override
  State<StatefulWidget> createState() {
    return RecordListState();
  }
}

class RecordListState extends State<RecordListWidget> {
  var _isLoading = true;

  var _emailvalue = null;
  var _passwordvalue = null;

  var items = [];
  var fields = [];

  _setlocaldata() async {
    print("setting localdata");
    _emailvalue = await storage.read(key: 'email');
    _passwordvalue = await storage.read(key: 'password');
    print("after localdata for $_emailvalue and $_passwordvalue");
    _fetchData();
  }

  RecordListState() {
    print("init list");
    _setlocaldata();
  }

  _fetchData() async {
    print("in fetch for $_emailvalue and $_passwordvalue");
    Dio dio = new Dio(new BaseOptions(headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
          "Basic " + base64Encode(utf8.encode('$_emailvalue:$_passwordvalue'))
    }));
    final url = serverbase + "/system/participants/jeager_2h_2918";
    final response = await dio.get(url);
    print("Fetching data");

    if (response.statusCode == 200) {
      final map = response.data;
      print("map:" + map.toString());
      print("----------------------------------------------------------------");
      print("records:" + map['records'].toString());
      setState(() {
        _isLoading = false;
        this.items = map['records'];
        this.fields = map['listfields'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Flutter Engine')),
        body: Center(
            child: ListView.builder(
                itemCount: this.items != null ? this.items.length : 0,
                itemBuilder: (context, i) {
                  final curitem = this.items[i];
                  return ListTile(
                    title: Text(curitem[this.fields[0]['name']]),
                    subtitle: Text(curitem[this.fields[1]['name']]),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecordViewWidget(curitem)));
                    },
                  );
                })));
  }
}
