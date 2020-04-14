import 'dart:convert';

import 'package:benayty/chopper/credentials_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatelessWidget {
  final String resetCode;

  ResetPassword({@required this.resetCode});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CredentialsService.create(),
      dispose: (_, CredentialsService service) => service.client.dispose(),
      child: _Body(
        resetCode: resetCode,
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final String resetCode;

  _Body({@required this.resetCode});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _resetCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _resetingPassword = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Scaffold(
            body: Stack(
              children: <Widget>[
                // background image
                Image.asset(
                  'assets/splash_background.png',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.fill,
                ),

                // title
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'استعادة كلمة المرور',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 20,
                        color: Color(0xff1f80a9),
                      ),
                    ),
                  ),
                ),

                // logo
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

                // form
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 3),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        // password field
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _passwordController,
                            textAlign: TextAlign.right,
                            obscureText: true,
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
                              hintText: 'أدخل كلمة مرور جديدة',
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

                        // confirm password field
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _confirmPasswordController,
                            textAlign: TextAlign.right,
                            obscureText: true,
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
                              hintText: 'أعد إدخال كلمة المرور الجديدة',
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
                          child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                _resetingPassword = true;
                              });
                              final response =
                                  await Provider.of<CredentialsService>(context,
                                          listen: false)
                                      .resetPassword({
                                'reset_code': widget.resetCode,
                                'password': _passwordController.text,
                                'password_confirm':
                                    _confirmPasswordController.text,
                              });

                              final data = json.decode(response.bodyString);

                              setState(() {
                                _resetingPassword = false;
                              });

                              String message = '';

                              if (data['status'] == 200) {
                                message = data['message'];
                              } else {
                                message = data['errors'][0];
                              }

                              _resetCodeController.clear();
                              _passwordController.clear();
                              _confirmPasswordController.clear();

                              showDialog(
                                context: context,
                                child: AlertDialog(
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      message,
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                      ),
                                    ),
                                  ),
                                  actions: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          if (data['status'] == 200) {
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        child: Text(
                                          'إغلاق',
                                          style: TextStyle(
                                            fontFamily: 'Cairo',
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
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
                                'إعادة إدخال كلمة المرور',
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
          _resetingPassword
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
