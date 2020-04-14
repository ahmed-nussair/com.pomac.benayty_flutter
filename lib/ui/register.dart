import 'dart:convert';

import 'package:benayty/chopper/credentials_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
final List codes = [
  {
    'name': 'مصر',
    'code': '+20',
    'flag': 'assets/egypt.png',
  },
  {
    'name': 'قيرغيزستان',
    'code': '+0966',
    'flag': 'assets/kirghizia.png',
  },
  {
    'name': 'الصين',
    'code': '+86',
    'flag': 'assets/china.png',
  },
  {
    'name': 'إيطاليا',
    'code': '+39 ',
    'flag': 'assets/italy.png',
  },
  {
    'name': 'الكويت',
    'code': '+965',
    'flag': 'assets/kuwait.png',
  },
];

class Register extends StatelessWidget {

  final Function onRegistered;

  Register({this.onRegistered});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CredentialsService.create(),
      dispose: (_, CredentialsService service) => service.client.dispose(),
      child: RegisterBody(onRegistered: onRegistered,),
    );
  }
}

class RegisterBody extends StatefulWidget {

  final Function onRegistered;

  RegisterBody({this.onRegistered});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterBody> {
  final _formKey = GlobalKey<FormState>();
  bool _checked = false;
  String _countryCode = '+966';

  final _nameTextController = TextEditingController();
  final _mobileTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  bool _registering = false;

  _setCountryCode(Function(String) func){
    showDialog(context: context,
      builder: (context){
        return AlertDialog(
          content: ListView(
            children: List.generate(codes.length, (index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        func(codes[index]['code']);
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset(codes[index]['flag'], scale: 20,),
                          Text(codes[index]['name']),
                          Text(codes[index]['code']),
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }

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
                      'التسجيل',
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
                          padding: const EdgeInsets.only(
                              right: 8.0, left: 8.0, bottom: 8.0),
                          child: TextFormField(
                            controller: _nameTextController,
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.only(
                                  top: 10.0, bottom: 10.0, left: 10.0, right: 30.0),
                              hintStyle: TextStyle(
                                fontFamily: 'Cairo',
                                color: Color(0xff1f80a9),
                              ),
                              hintText: 'الاسم',
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
                          padding: const EdgeInsets.only(
                              right: 8.0, left: 8.0, bottom: 8.0),
                          child: TextFormField(
                            controller: _emailTextController,
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.only(
                                  top: 10.0, bottom: 10.0, left: 10.0, right: 30.0),
                              hintStyle: TextStyle(
                                fontFamily: 'Cairo',
                                color: Color(0xff1f80a9),
                              ),
                              hintText: 'البريد الإلكتروني',
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
                          padding: const EdgeInsets.only(
                              right: 8.0, left: 8.0, bottom: 8.0),
                          child: Stack(
                            children: <Widget>[
                              TextFormField(
                                controller: _mobileTextController,
                                keyboardType: TextInputType.phone,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.only(
                                      top: 10.0, bottom: 10.0, left: 10.0, right: 90.0),
                                  hintStyle: TextStyle(
                                    fontFamily: 'Cairo',
                                    color: Color(0xff1f80a9),
                                  ),
                                  hintText: 'الجوال - بدون مفتاح الدولة',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Color(0xff1f80a9),
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0.0, bottom: 0.0, right: 0.0,
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(50.0)),
                                    color: Color(0xff1f80a9),
                                  ),
                                  child: Text(
                                    _countryCode,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Cairo',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0, left: 8.0, bottom: 8.0),
                          child: TextFormField(
                            controller: _passwordTextController,
                            obscureText: true,
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.only(
                                  top: 10.0, bottom: 10.0, left: 10.0, right: 30.0),
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
//                        Padding(
//                          padding: const EdgeInsets.only(top: 6.0, right: 20.0, bottom: 20.0,),
//                          child: Container(
//                            alignment: Alignment.centerRight,
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.end,
//                              children: <Widget>[
//                                Text('أوافق على سياسة الاستخدام',
//                                  style: TextStyle(
//                                    fontFamily: 'Cairo',
//                                    color: Color(0xff1f80a9),
//                                  ),
//                                ),
//
//                                Checkbox(value: _checked, onChanged: (bool value) {
//                                  setState(() {
//                                    _checked = value;
//                                  });
//                                },
//                                  activeColor: Color(0xff1f80a9),
//
//                                ),
//                              ],
//                            ),
//                          ),
//                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0, left: 8.0, bottom: 8.0),
                          child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                _registering = true;
                              });
                              final data = await
                              Provider.of<CredentialsService>(context, listen: false)
                                  .register({'name': _nameTextController.text,
                                'phone': '${_mobileTextController.text}',
                                'email': _emailTextController.text,
                                'password': _passwordTextController.text,
                              });

                              print(data.bodyString);

                              setState(() {
                                _registering = false;
                              });

                              final theData = json.decode(data.bodyString);

                              if(theData['status'] == 200){
                                Navigator.of(context).pop();
                                widget.onRegistered();
                              } else {
                                showDialog(context: context,
                                  child: AlertDialog(
                                    content: Text(theData['errors'][0]),
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
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                color: Color(0xff1f80a9),
                              ),
                              child: Text(
                                'تسجيل',
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
          _registering?Positioned(
            right: 0.0, left: 0.0, top: 0.0, bottom: 0.0,
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
          ):Container(),
        ],
      ),
    );
  }
}
