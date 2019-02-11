import 'package:flutter/material.dart';
import './recordedit.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

var serverbase = '';

final storage = new FlutterSecureStorage();

class RecordViewWidget extends StatefulWidget {
  final item;

  RecordViewWidget(this.item);

  @override
  State<StatefulWidget> createState() {
    print('item:' + this.item.toString());
    return RecordViewState(this.item);
  }
}

class RecordViewState extends State<RecordViewWidget> {
  var _isLoading = true;

  var _emailvalue = null;
  var _passwordvalue = null;

  var fields = [];
  var item = {};

  _setlocaldata() async {
    print("setting localdata");
    _emailvalue = await storage.read(key: 'email');
    _passwordvalue = await storage.read(key: 'password');
    serverbase = await storage.read(key: 'serverbase');
    print("after localdata for $_emailvalue and $_passwordvalue");
    _fetchData();
  }

  RecordViewState(this.item) {
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
    final url = serverbase +
        "/system/participants/jeager_2h_2918/" +
        this.item['id'].toString();
    print("requestting url:" + url);
    final response = await dio.get(url);
    print("Fetching data");

    if (response.statusCode == 200) {
      final map = response.data;
      print("map:" + map.toString());
      print("----------------------------------------------------------------");
      print("record:" + map['record'].toString());
      print("listfields:" + map['listfields'].toString());
      //final assignmentsjson = map['record'];
      setState(() {
        _isLoading = false;
        this.item = map['record'];
        this.fields = map['listfields'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Engine'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecordEditWidget(this.item)));
              },
            )
          ],
        ),
        body: ListView.builder(
            itemCount: this.fields != null ? this.fields.length : 0,
            itemBuilder: (context, i) {
              final curfield = this.fields[i];
              print("processing:" + curfield.toString());
              print("using:" + this.item.toString());
              return ListTile(
                title: Text(curfield['label']),
                subtitle: Text(this.item[curfield['name']]['data'].toString()),
              );
            }));
  }
}
