import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddAdvertisementPage2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return _Body();
  }
}

class _Body extends StatefulWidget {
  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.all(10.0),
                    child: Text('اسم الإعلان',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: Color(0xff1f80a9),
                      ),
                    ),
                  ),
                  TextFormField(
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      fillColor: Color(0xff1f80a9),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff1f80a9),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff1f80a9),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      hintText: 'اسم الإعلان',
                      contentPadding: EdgeInsets.only(right: 15.0),
                      hintStyle: TextStyle(
                        fontFamily: 'Cairo',
                        color: Color(0xff1f80a9),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.all(10.0),
                    child: Text('الجوال',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: Color(0xff1f80a9),
                      ),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      fillColor: Color(0xff1f80a9),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff1f80a9),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff1f80a9),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      hintText: 'الجوال',
                      contentPadding: EdgeInsets.only(right: 15.0),
                      hintStyle: TextStyle(
                        fontFamily: 'Cairo',
                        color: Color(0xff1f80a9),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.all(10.0),
                    child: Text('الوصف',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: Color(0xff1f80a9),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(
                        width: 1,
                        color: Color(0xff1f80a9),
                      ),
                    ),
                    child: Text('الوصف',

                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: Color(0xff1f80a9),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 90.0, left: 90.0,),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xff1f80a9),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('إرسال',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

