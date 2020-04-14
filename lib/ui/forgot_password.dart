import 'dart:convert';

import 'package:benayty/chopper/credentials_service.dart';
import 'package:benayty/ui/reset_password.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'custom_show_dialog.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CredentialsService.create(),
//      dispose: (_, CredentialsService service) => service.client.dispose(),
      child: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTextController = TextEditingController();

  bool _checkingEmail = false;

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
                      'نسيت كلمة المرور؟',
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
                        // email field
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty)
                                return 'من فضلك أدخل البريد الإليكتروني';
                              return null;
                            },
                            controller: _emailTextController,
                            keyboardType: TextInputType.emailAddress,
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
                              hintText: 'البريد الإليكتروني',
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
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  _checkingEmail = true;
                                });
                                final response =
                                await Provider.of<CredentialsService>(context,
                                    listen: false)
                                    .forgotPassword({
                                  'email': _emailTextController.text,
                                });

                                final data = json.decode(response.bodyString);

                                setState(() {
                                  _checkingEmail = false;
                                });

                                String message = '';

                                message = data['message'];
                                _emailTextController.clear();

                                showDialog(
                                  context: context,
                                  child: data['status'] == 200
                                      ? _CheckingResetCode(
                                    message: message,
                                    onResponse: (value) {
                                      return Provider.of<
                                          CredentialsService>(
                                        context,
                                        listen: false,
                                      ).checkResetCode({
                                        'reset_code': value,
                                      });
                                    },
                                  )
                                      : CustomAlertDialog(
                                    content: Container(
                                      height: 50,
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
                                          child: Text('إغلاق'),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                    ],
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
                                'استعادة كلمة المرور',
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
          _checkingEmail
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

class _CheckingResetCode extends StatefulWidget {
  final String message;
  final Future<Response> Function(String) onResponse;

  _CheckingResetCode({@required this.message, @required this.onResponse});

  @override
  __CheckingResetCodeState createState() => __CheckingResetCodeState();
}

class __CheckingResetCodeState extends State<_CheckingResetCode> {
  final _resetCodeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _wrongToken = false;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CredentialsService.create(),
      dispose: (_, CredentialsService service) => service.client.dispose(),
      child: CustomAlertDialog(
        content: Container(
          height: 300,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.message,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'من فضلك أدخل الكود';
                      }
                      return null;
                    },
                    controller: _resetCodeController,
                    decoration: InputDecoration(
                      hintText: 'Enter the reset code',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              _wrongToken
                  ? Text(
                'الكود غير صحيح',
                style: TextStyle(
                  color: Colors.red,
                ),
              )
                  : Container(),
              RaisedButton(
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (_formKey.currentState.validate()) {
                    var response =
                    await widget.onResponse(_resetCodeController.text);

                    final data = json.decode(response.bodyString);

                    if (data['status'] == 200) {
                      // you can change the password
                      setState(() {
                        _wrongToken = false;
                      });

                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              ResetPassword(
                                resetCode: _resetCodeController.text,
                              )));
                    } else {
                      setState(() {
                        _wrongToken = true;
                      });
                    }
                  } else {
                    setState(() {
                      _wrongToken = false;
                    });
                  }
                },
                child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'التأكد من الكود وتغيير كلمة المرور',
                      textAlign: TextAlign.center,
                    )),
              ),
              RaisedButton(

                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Navigator.of(context).pop();
                },
                child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'إلغاء',
                      textAlign: TextAlign.center,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
