import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
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
    return ListView(
      children: <Widget>[
        // The logo
        Container(
          alignment: Alignment.topCenter,
          child: Image.asset(
            'assets/logo.png',
            scale: 1.5,
          ),
        ),

        // The form
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // user name
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    hintText: 'اسم المستخدم',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Color(0xff1f80a9),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Color(0xff1f80a9),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Color(0xff1f80a9),
                      ),
                    ),
                    contentPadding: EdgeInsets.only(right: 30.0),
                    hintStyle: TextStyle(
                      color: Color(0xff1f80a9),
                      fontFamily: 'Cairo',
                    ),
                    focusColor: Color(0xff1f80a9),
                  ),
                ),
              ),

              // email
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textAlign: TextAlign.end,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'البريد الإليكتروني',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Color(0xff1f80a9),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Color(0xff1f80a9),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Color(0xff1f80a9),
                      ),
                    ),
                    contentPadding: EdgeInsets.only(right: 30.0),
                    hintStyle: TextStyle(
                      color: Color(0xff1f80a9),
                      fontFamily: 'Cairo',
                    ),
                    focusColor: Color(0xff1f80a9),
                  ),
                ),
              ),

              // mobile
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textAlign: TextAlign.end,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'الجوال',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Color(0xff1f80a9),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Color(0xff1f80a9),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Color(0xff1f80a9),
                      ),
                    ),
                    contentPadding: EdgeInsets.only(right: 30.0),
                    hintStyle: TextStyle(
                      color: Color(0xff1f80a9),
                      fontFamily: 'Cairo',
                    ),
                    focusColor: Color(0xff1f80a9),
                  ),
                ),
              ),

              // title
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    hintText: 'عنوان الرسالة',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Color(0xff1f80a9),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Color(0xff1f80a9),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Color(0xff1f80a9),
                      ),
                    ),
                    contentPadding: EdgeInsets.only(right: 30.0),
                    hintStyle: TextStyle(
                      color: Color(0xff1f80a9),
                      fontFamily: 'Cairo',
                    ),
                    focusColor: Color(0xff1f80a9),
                  ),
                ),
              ),

              // content
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textAlign: TextAlign.end,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'محتوى الرسالة',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Color(0xff1f80a9),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Color(0xff1f80a9),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Color(0xff1f80a9),
                      ),
                    ),
                    contentPadding: EdgeInsets.only(right: 30.0),
                    hintStyle: TextStyle(
                      color: Color(0xff1f80a9),
                      fontFamily: 'Cairo',
                    ),
                    focusColor: Color(0xff1f80a9),
                  ),
                ),
              ),

              // Send button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color(0xff1f80a9),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Text(
                    'إرسال الرسالة',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
