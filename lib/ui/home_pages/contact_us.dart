import 'dart:convert';

import 'package:benayty/chopper/contact_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => ContactService.create(),
      dispose: (_, ContactService service) => service.client.dispose(),
      child: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  final _formKey = GlobalKey<FormState>();

  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
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
                      validator: (value) {
                        if (value.isEmpty) return 'من فضلك أدخل الاسم';
                        return null;
                      },
                      controller: _userNameController,
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
                      validator: (value) {
                        if (value.isEmpty)
                          return 'من فضلك أدخل البريد الإلكتروني';
                        return null;
                      },
                      controller: _emailController,
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
                      validator: (value) {
                        if (value.isEmpty) return 'من فضلك أدخل رقم الجوال';
                        return null;
                      },
                      controller: _mobileController,
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
                      validator: (value) {
                        if (value.isEmpty) return 'من فضلك أدخل عنوان الرسالة';
                        return null;
                      },
                      controller: _titleController,
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
                      validator: (value) {
                        if (value.isEmpty) return 'من فضلك اكتب محتوى الرسالة';
                        return null;
                      },
                      controller: _contentController,
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
                    child: GestureDetector(
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _sending = true;
                          });
                          final response = await Provider.of<ContactService>(
                              context, listen: false).contactUs({
                            'name': _userNameController.text,
                            'email': _emailController.text,
                            'phone': _mobileController.text,
                            'subject': _titleController.text,
                            'message': _contentController.text,
                          });

                          setState(() {
                            _sending = false;
                          });

                          final data = json.decode(response.bodyString);

                          showDialog(context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Container(
                                    child: Text(data['message'],
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
                              }
                          );
                        }
                      },
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
                  ),
                ],
              ),
            ),
          ],
        ),
        _sending ? Positioned(
          right: 0.0,
          left: 0.0,
          top: 0.0,
          bottom: 0.0,
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
    );
  }
}
