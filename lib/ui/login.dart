import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 30.0),
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
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: true,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 30.0),
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
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0, right: 35.0, bottom: 20.0,),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text('نسيت كلمة المرور',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            color: Color(0xff1f80a9),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          print('Login');
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
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
    );
  }
}
