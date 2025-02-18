import 'dart:convert';

import 'package:benayty/chopper/credentials_service.dart';
import 'package:benayty/ui/forgot_password.dart';
import 'package:benayty/ui/register.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart';
import 'home.dart';

class Login extends StatelessWidget {

  final Function onLogin;

  Login({this.onLogin});
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CredentialsService.create(),
      dispose: (_, CredentialsService service) => service.client.dispose(),
      child: LoginBody(onLogin: onLogin,),
    );
  }
}

class LoginBody extends StatefulWidget {
  final Function onLogin;

  LoginBody({this.onLogin});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginBody> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _mobileTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  bool _loggingIn = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Scaffold(
            body: Stack(
              children: <Widget>[
                Image.asset(
                  'assets/splash_background.png',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 20,
                        color: Color(0xff1f80a9),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/logo.png',
                      scale: 1.7,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 3),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _mobileTextController,
                            keyboardType: TextInputType.phone,
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  left: 10.0,
                                  right: 30.0),
                              hintStyle: TextStyle(
                                fontFamily: 'Cairo',
                                color: Color(0xff1f80a9),
                              ),
                              hintText: 'الجوال',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xff1f80a9),
                                ),
                                borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _passwordTextController,
                            obscureText: true,
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  left: 10.0,
                                  right: 30.0),
                              hintStyle: TextStyle(
                                fontFamily: 'Cairo',
                                color: Color(0xff1f80a9),
                              ),
                              hintText: 'كلمة المرور',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xff1f80a9),
                                ),
                                borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                              ),
                            ),
                          ),
                        ),

//                        // forgot password
//                        Padding(
//                          padding: const EdgeInsets.only(
//                            top: 6.0,
//                            right: 35.0,
//                            bottom: 20.0,
//                          ),
//                          child: GestureDetector(
////                            onTap: () =>
////                                Navigator.of(context).push(MaterialPageRoute(
////                                    builder: (context) => ForgotPassword())),
//                            child: Container(
//                              alignment: Alignment.centerRight,
//                              child: Text(
//                                'نسيت كلمة المرور',
//                                style: TextStyle(
//                                  fontFamily: 'Cairo',
//                                  color: Color(0xff1f80a9),
//                                  decoration: TextDecoration.underline,
//                                ),
//                              ),
//                            ),
//                          ),
//                        ),


                        Padding(
                          padding: const EdgeInsets.only(
                            top: 6.0,
                            right: 35.0,
                            bottom: 20.0,
                          ),
                          child: GestureDetector(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        Register(
                                          onRegistered: () {
                                            Navigator.of(context)
                                                .pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Home()));
                                          },
                                        ))),
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'مستخدم جديد؟ قم بالتسجيل',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: Color(0xff1f80a9),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () async{
                              var connectivityResult =
                              await (Connectivity().checkConnectivity());
                              if (connectivityResult !=
                                  ConnectivityResult.mobile &&
                                  connectivityResult !=
                                      ConnectivityResult.wifi) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Container(
                                          child: Text(
                                            'يجب عليك الاتصال بالإنترنت لكي تتمكن من تسجيل الدخول',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                            ),
                                          ),
                                        ),
                                        actions: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: () =>
                                                  Navigator.of(context).pop(),
                                              child: Text('إغلاق'),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                                return;
                              }
                              setState(() {
                                _loggingIn = true;
                              });
                              final response = await
                              Provider.of<CredentialsService>(context, listen: false)
                                  .login({'phone': _mobileTextController.text,
                                'password': _passwordTextController.text,});

                              final data = json.decode(response.bodyString);


                              print(response.bodyString);

                              setState(() {
                                _loggingIn = false;
                              });

                              print(data);
                              if (data['status'] == 200) {
                                SharedPreferences prefs = await SharedPreferences
                                    .getInstance();

                                prefs.setString('token', data['token']);
                                prefs.setString(
                                    'userName', data['user_data']['name']);
                                prefs.setString(
                                    'userPhone', data['user_data']['phone']);
                                prefs.setString('userImagePath',
                                    data['user_data']['imagePath']);

                                Globals.token = prefs.getString('token');

                                Navigator.of(context).pop();
                                if (widget.onLogin != null)
                                  widget.onLogin();
                              } else {
                                _mobileTextController.clear();
                                _passwordTextController.clear();
                                showDialog(context: context,
                                  child: AlertDialog(
                                    content: Text(data['errors'][0]),
                                    actions: <Widget>[Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () => Navigator.of(context).pop(),
                                        child: Text('إغلاق',
                                          style: TextStyle(
                                            fontFamily: 'Cairo',
                                          ),
                                        ),
                                      ),
                                    )],
                                  ),
                                );
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                                color: Color(0xff1f80a9),
                              ),
                              child: Text(
                                'دخول',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _loggingIn
              ? Positioned(
            child: Container(
              color: Colors.black.withOpacity(0.2),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            ),
          )
              : Container(),
        ],
      ),
    );
  }
}
