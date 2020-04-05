import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddAdvertisementPage2 extends StatelessWidget {
  final int mainItemId;
  final int secondaryItemId;
  final int areaId;
  final int cityId;

  AddAdvertisementPage2({@required this.mainItemId,
    @required this.secondaryItemId,
    @required this.areaId,
    @required this.cityId});

  @override
  Widget build(BuildContext context) {
    return _Body(
      mainItemId: mainItemId,
      secondaryItemId: secondaryItemId,
      areaId: areaId,
      cityId: cityId,
    );
  }
}

class _Body extends StatefulWidget {
  final int mainItemId;
  final int secondaryItemId;
  final int areaId;
  final int cityId;

  _Body({@required this.mainItemId,
    @required this.secondaryItemId,
    @required this.areaId,
    @required this.cityId});

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  final _formKey = GlobalKey<FormState>();

  File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
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
                            child: Text(
                              'اسم الإعلان',
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
                              enabledBorder: OutlineInputBorder(
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
                            child: Text(
                              'الجوال',
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
                              enabledBorder: OutlineInputBorder(
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
                            child: Text(
                              'الوصف',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: Color(0xff1f80a9),
                              ),
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
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
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff1f80a9),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              hintText: 'الوصف',
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
                            child: Text(
                              'إضافة صورة',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: Color(0xff1f80a9),
                              ),
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  border: Border.all(
                                    width: 1,
                                    color: Color(0xff1f80a9),
                                  ),
                                ),
                                child: GestureDetector(
                                    onTap: () async {
                                      try {
                                        File _file = await FilePicker.getFile(
                                            type: FileType.image,
                                            fileExtension: '');

                                        setState(() {
                                          image = _file;
                                        });
                                      } catch (e) {}
                                    },
                                    child: Icon(
                                      Icons.add_photo_alternate,
                                      color: Color(0xff1f80a9),
                                    )),
                              ),
                              Positioned(
                                right: 0.0,
                                top: 0.0,
                                bottom: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: image == null
                                      ? Container()
                                      : Image.file(image),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 90.0,
                left: 90.0,
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xff1f80a9),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'إرسال',
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
