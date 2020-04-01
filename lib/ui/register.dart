import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool _checked = false;
  String _countryCode = '+966';

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
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
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
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
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
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
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
                            child: GestureDetector(
                              onTap: (){

                                _setCountryCode((String code){
                                  setState(() {
                                    _countryCode = code;
                                  });
                                });

                              },
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
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
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 8.0, bottom: 8.0),
                      child: TextFormField(
                        obscureText: true,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
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
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0, right: 20.0, bottom: 20.0,),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text('أوافق على سياسة الاستخدام',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: Color(0xff1f80a9),
                              ),
                            ),

                            Checkbox(value: _checked, onChanged: (bool value) {
                              setState(() {
                                _checked = value;
                              });
                            },
                              activeColor: Color(0xff1f80a9),

                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 8.0, bottom: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          print('Login');
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
    );
  }
}
