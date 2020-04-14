import 'dart:convert';

import 'package:benayty/chopper/main_categories_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../globals.dart';
import '../../login.dart';

class AddAdvertisementPage1 extends StatelessWidget {
  final Function(
      int,
      int,
      int,
      int,
      ) onNextPage;

  AddAdvertisementPage1({@required this.onNextPage});

  @override
  Widget build(BuildContext context) {
    return Globals.token.isNotEmpty ? Provider(
      create: (_) => MainCategoriesService.create(),
      dispose: (_, MainCategoriesService service) => service.client.dispose(),
      child: _Body(
        onNextPage: onNextPage,
      ),
    ) : Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('قم بتسجيل الدخول حتى تتمكن من إضافة إعلان',
            style: TextStyle(
                fontFamily: 'Cairo'
            ),
          ),
          RaisedButton(
            onPressed: () =>
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Login())),
            child: Text('تسجيل الدخول',
              style: TextStyle(
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final Function(int, int, int, int) onNextPage;

  _Body({@required this.onNextPage});
  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  int _mainItemId = -1;
  int _secondaryItemId = -1;
  int _areaId = -1;
  int _cityId = -1;

  bool _mainItem = true;
  bool _secondaryItem = true;
  bool _area = true;
  bool _city = true;

  String _mainItemName = '';
  String _secondaryItemName = '';
  String _areaName = '';
  String _cityName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            'القسم الرئيسي',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              color: Color(0xff1f80a9),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final rawData =
                            await Provider.of<MainCategoriesService>(
                                context,
                                listen: false)
                                .getMainCategories();
                            final data = json.decode(rawData.bodyString);
                            final List list = data['data'];

                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    titlePadding: EdgeInsets.all(0.0),
                                    contentPadding: EdgeInsets.all(0.0),
                                    title: Container(
                                      padding: EdgeInsets.all(10.0),
                                      color: Color(0xff1f80a9),
                                      child: Text(
                                        'القسم الرئيسي',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    content: _MainItemsDialog(
                                      list: list,
                                      onItemSelected: (int id, String value) {
                                        setState(() {
                                          _mainItemName = value;
                                          _mainItemId = id;

                                          _secondaryItemId = -1;
                                          _secondaryItemName = '';

                                          _mainItem = true;
                                        });

                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              border: Border.all(
                                width: 1,
                                color: Color(0xff1f80a9),
                              ),
                            ),
                            child: Text(
                              _mainItemId != -1
                                  ? _mainItemName
                                  : 'القسم الرئيسي',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: Color(0xff1f80a9),
                              ),
                            ),
                          ),
                        ),
                        _mainItem
                            ? Container()
                            : Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'القسم الرئيسي مطلوب',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              color: Colors.red,
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
                            'القسم الفرعي',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              color: Color(0xff1f80a9),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_mainItemId != -1) {
                              final rawData =
                              await Provider.of<MainCategoriesService>(
                                  context,
                                  listen: false)
                                  .getSecondaryCategories(_mainItemId);
                              final data = json.decode(rawData.bodyString);
                              final List list = data['data'];

                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      titlePadding: EdgeInsets.all(0.0),
                                      contentPadding: EdgeInsets.all(0.0),
                                      title: Container(
                                        padding: EdgeInsets.all(10.0),
                                        color: Color(0xff1f80a9),
                                        child: Text(
                                          'القسم الفرعي',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      content: _SecondaryItemsDialog(
                                        list: list,
                                        onItemSelected: (int id, String value) {
                                          setState(() {
                                            _secondaryItemId = id;
                                            _secondaryItemName = value;

                                            _secondaryItem = true;
                                          });

                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    );
                                  });
                            }
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              border: Border.all(
                                width: 1,
                                color: Color(0xff1f80a9),
                              ),
                            ),
                            child: Text(
                              _secondaryItemId != -1
                                  ? _secondaryItemName
                                  : 'القسم الفرعي',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: Color(0xff1f80a9),
                              ),
                            ),
                          ),
                        ),
                        _secondaryItem
                            ? Container()
                            : Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'القسم الفرعي مطلوب',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              color: Colors.red,
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
                            'المنطقة',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              color: Color(0xff1f80a9),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final rawData =
                            await Provider.of<MainCategoriesService>(
                                context,
                                listen: false)
                                .getAreas();
                            final data = json.decode(rawData.bodyString);
                            final List list = data['data'];

                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    titlePadding: EdgeInsets.all(0.0),
                                    contentPadding: EdgeInsets.all(0.0),
                                    title: Container(
                                      padding: EdgeInsets.all(10.0),
                                      color: Color(0xff1f80a9),
                                      child: Text(
                                        'المنطقة',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    content: _AreasDialog(
                                      list: list,
                                      onItemSelected: (int id, String value) {
                                        setState(() {
                                          _areaName = value;
                                          _areaId = id;

                                          _cityId = -1;
                                          _cityName = '';

                                          _area = true;
                                        });

                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              border: Border.all(
                                width: 1,
                                color: Color(0xff1f80a9),
                              ),
                            ),
                            child: Text(
                              _areaId != -1 ? _areaName : 'المنطقة',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: Color(0xff1f80a9),
                              ),
                            ),
                          ),
                        ),
                        _area
                            ? Container()
                            : Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'من فضلك أدخل المنطقة',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              color: Colors.red,
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
                            'المدينة',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              color: Color(0xff1f80a9),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_areaId != -1) {
                              final rawData =
                              await Provider.of<MainCategoriesService>(
                                  context,
                                  listen: false)
                                  .getCities(_areaId);
                              final data = json.decode(rawData.bodyString);
                              final List list = data['data'];

                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      titlePadding: EdgeInsets.all(0.0),
                                      contentPadding: EdgeInsets.all(0.0),
                                      title: Container(
                                        padding: EdgeInsets.all(10.0),
                                        color: Color(0xff1f80a9),
                                        child: Text(
                                          'المدينة',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      content: _CitiesDialog(
                                        list: list,
                                        onItemSelected: (int id, String value) {
                                          setState(() {
                                            _cityId = id;
                                            _cityName = value;

                                            _city = true;
                                          });

                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    );
                                  });
                            }
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              border: Border.all(
                                width: 1,
                                color: Color(0xff1f80a9),
                              ),
                            ),
                            child: Text(
                              _cityId != -1 ? _cityName : 'المدينة',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: Color(0xff1f80a9),
                              ),
                            ),
                          ),
                        ),
                        _city
                            ? Container()
                            : Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'من فضلك أدخل المدينة',
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
          Padding(
            padding: const EdgeInsets.only(
              right: 90.0,
              left: 90.0,
            ),
            child: GestureDetector(
              onTap: () {
                if (_mainItemId == -1 ||
                    _secondaryItemId == -1 ||
                    _areaId == -1 ||
                    _cityId == -1) {
                  setState(() {
                    if (_mainItemId == -1) {
                      _mainItem = false;
                    } else {
                      _mainItem = true;
                    }

                    if (_secondaryItemId == -1) {
                      _secondaryItem = false;
                    } else {
                      _secondaryItem = true;
                    }

                    if (_areaId == -1) {
                      _area = false;
                    } else {
                      _area = true;
                    }

                    if (_cityId == -1) {
                      _city = false;
                    } else {
                      _city = true;
                    }
                  });
                } else
                  widget.onNextPage(
                      _mainItemId, _secondaryItemId, _areaId, _cityId);
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Color(0xff1f80a9),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'التالي',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    bottom: 0.0,
                    right: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MainItemsDialog extends StatelessWidget {
  final List list;
  final Function(int, String) onItemSelected;

  _MainItemsDialog({@required this.list, @required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(list.length, (index) {
        return GestureDetector(
          onTap: () {
            onItemSelected(list[index]['id'], list[index]['name']);
          },
          child: ListTile(
            title: Text(
              list[index]['name'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cairo',
              ),
            ),
            subtitle: Divider(
              color: Color(0xff1f80a9),
              thickness: 1,
            ),
          ),
        );
      }),
    );
  }
}

class _SecondaryItemsDialog extends StatelessWidget {
  final List list;
  final Function(int, String) onItemSelected;

  _SecondaryItemsDialog({@required this.list, @required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(list.length, (index) {
        return GestureDetector(
          onTap: () {
            onItemSelected(list[index]['id'], list[index]['name']);
          },
          child: ListTile(
            title: Text(
              list[index]['name'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cairo',
              ),
            ),
            subtitle: Divider(
              color: Color(0xff1f80a9),
              thickness: 1,
            ),
          ),
        );
      }),
    );
  }
}

class _AreasDialog extends StatelessWidget {
  final List list;
  final Function(int, String) onItemSelected;

  _AreasDialog({@required this.list, @required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(list.length, (index) {
        return GestureDetector(
          onTap: () {
            onItemSelected(list[index]['id'], list[index]['name']);
          },
          child: ListTile(
            title: Text(
              list[index]['name'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cairo',
              ),
            ),
            subtitle: Divider(
              color: Color(0xff1f80a9),
              thickness: 1,
            ),
          ),
        );
      }),
    );
  }
}

class _CitiesDialog extends StatelessWidget {
  final List list;
  final Function(int, String) onItemSelected;

  _CitiesDialog({@required this.list, @required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(list.length, (index) {
        return GestureDetector(
          onTap: () {
            onItemSelected(list[index]['id'], list[index]['name']);
          },
          child: ListTile(
            title: Text(
              list[index]['name'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cairo',
              ),
            ),
            subtitle: Divider(
              color: Color(0xff1f80a9),
              thickness: 1,
            ),
          ),
        );
      }),
    );
  }
}
