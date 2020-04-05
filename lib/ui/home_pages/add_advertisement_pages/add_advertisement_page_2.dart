import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:benayty/chopper/advertisement_service.dart';

import '../../../globals.dart';

class AddAdvertisementPage2 extends StatelessWidget {
  final int mainItemId;
  final int secondaryItemId;
  final int areaId;
  final int cityId;
  final Function onSentSuccessfully;

  AddAdvertisementPage2({@required this.mainItemId,
    @required this.secondaryItemId,
    @required this.areaId,
    @required this.cityId, @required this.onSentSuccessfully});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => AdvertisementService.create(),
      dispose: (_, AdvertisementService service) => service.client.dispose(),
      child: _Body(
        mainItemId: mainItemId,
        secondaryItemId: secondaryItemId,
        areaId: areaId,
        cityId: cityId,
        onSentSuccessfully: onSentSuccessfully,
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final int mainItemId;
  final int secondaryItemId;
  final int areaId;
  final int cityId;
  final Function onSentSuccessfully;

  _Body({@required this.mainItemId,
    @required this.secondaryItemId,
    @required this.areaId,
    @required this.cityId, @required this.onSentSuccessfully});

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _mobile = '';
  String _description = '';
  File _image;
  bool _imageSet = true;

  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          resizeToAvoidBottomInset: true,
          body: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: ListView(
                      children: <Widget>[

                        // Ad title
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
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'من فضلك أدخل اسم الإعلان';
                                  }
                                  _title = value;
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),

                        // mobile
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
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'من فضلك أدخل الجوال';
                                  }
                                  _mobile = value;
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),

                        // Description
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
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'من فضلك أدخل وصف الإعلان';
                                  }
                                  _description = value;
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),

                        // Image
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
                                            File _file = await FilePicker
                                                .getFile(
                                                type: FileType.image,
                                                fileExtension: '');

                                            setState(() {
                                              _image = _file;
                                            });
                                          } catch (e) {
                                            print(e.toString());
                                          }
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
                                      child: _image == null
                                          ? Container()
                                          : Image.file(_image),
                                    ),
                                  ),
                                ],
                              ),
                              _imageSet ? Container() : Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'من فضلك أضف صورة للإعلان',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Send button
                Padding(
                  padding: const EdgeInsets.only(
                    right: 90.0,
                    left: 90.0,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState.validate() && _image != null) {
                        setState(() {
                          _imageSet = true;
                          _sending = true;
                        });

                        final data = await Globals.addAdvertisement(
                          token: '1583861467mUAX0TtHPz1583861467',
                          areaId: widget.areaId,
                          cityId: widget.cityId,
                          mainItemId: widget.mainItemId,
                          secondaryItemId: widget.secondaryItemId,
                          title: _title,
                          image: _image,
                          description: _description,
                          phone: _mobile,
                        );

                        setState(() {
                          _sending = false;
                        });

                        showDialog(context: context,
                          child: AlertDialog(
                            title: Container(
                              alignment: Alignment.topCenter,
                              child: Text(
                                data['status'] == 200
                                    ? data['message']
                                    : 'هناك مشكلة',
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
                                    widget.onSentSuccessfully();
                                  },
                                  child: Text('إغلاق',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        setState(() {
                          _imageSet = false;
                        });
                      }
                    },
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
                ),
              ],
            ),
          ),
        ),
        _sending ? Positioned(
          top: 0.0,
          bottom: 0.0,
          right: 0.0,
          left: 0.0,
          child: Container(
            alignment: Alignment.center,
            color: Colors.black.withOpacity(0.2),
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
