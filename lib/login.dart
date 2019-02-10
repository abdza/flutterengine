import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import './home.dart';

class LoginWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginWidget> {
  /* credit goes to putraxor for the login layout
  https://github.com/putraxor/flutter-login-ui/blob/master/lib/login_page.dart
   */

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final _storage = new FlutterSecureStorage();

  var _emailvalue = '';
  var _passwordvalue = '';
  var _invalidlogin = false;

  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      onSaved: (String value) {
        setState(() {
          this._emailvalue = value;
        });
      },
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      onSaved: (String value) {
        setState(() {
          this._passwordvalue = value;
        });
      },
    );

    _login(context) async {
      Dio dio = new Dio(new BaseOptions(headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization":
            "Basic " + base64Encode(utf8.encode('$_emailvalue:$_passwordvalue'))
      }));
      print("Trying to login");
      final url = 'http://10.132.1.135:8800/login';
      try {
        final response = await dio.post(url);
        if(response.statusCode == 200){
          print(response.data.toString());
          await _storage.write(key: 'email', value:_emailvalue);
          await _storage.write(key: 'password', value:_passwordvalue);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeWidget())
          );
        }
      } on DioError catch (e) {
        if(e.response!=null){
          setState((){
            this._invalidlogin = true;
          });
        }
      }
    }

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          this._formKey.currentState.save();
          print('email:' + this._emailvalue);
          print('password:' + this._passwordvalue);
          _login(context);
          /* Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeWidget())
          );*/
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Flutter Engine'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          autovalidate: false,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              SizedBox(height: 48.0),
              email,
              SizedBox(height: 8.0),
              password,
              SizedBox(height: 24.0),
              this._invalidlogin
                  ? Text("Login invalid")
                  : Container(width: 0, height: 0),
              loginButton,
              forgotLabel
            ],
          ),
        ),
      ),
    );
  }
}
