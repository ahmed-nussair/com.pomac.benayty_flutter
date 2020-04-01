import 'dart:convert';

import 'package:benayty/chopper/main_categories_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondaryPage extends StatelessWidget {
  final int mainCategoryId;
  final Function onBackPressed;

  SecondaryPage({
    @required this.mainCategoryId,
    @required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => MainCategoriesService.create(),
      dispose: (_, MainCategoriesService service) => service.client.dispose(),
      child: _SecondaryPageBody(
        onBackPressed: onBackPressed,
        mainCategoryId: mainCategoryId,
      ),
    );
  }
}

class _SecondaryPageBody extends StatelessWidget {
  final int mainCategoryId;
  final Function onBackPressed;

  _SecondaryPageBody(
      {@required this.mainCategoryId, @required this.onBackPressed});

  @override
  Widget build(BuildContext context) {

    int _areaId = -1;
    return WillPopScope(
      onWillPop: () {
        onBackPressed();
        return null;
      },
      child: Scaffold(
          body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async{
                    final rawData = await Provider.of<MainCategoriesService>(context, listen: false).getSecondaryCategories(mainCategoryId);
                    final data = json.decode(rawData.bodyString);
                    final List list = data['data'];
                    showDialog(context: context,
                      builder: (context){
                        return AlertDialog(
                          titlePadding: EdgeInsets.all(0.0),
                          contentPadding: EdgeInsets.all(0.0),
                          title: Container(
                            padding: EdgeInsets.all(10.0),
                            color: Color(0xff1f80a9),
                            child: Text('اختر القسم الفرعي',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          content: _DialogItems(
                            mainCategoryId: mainCategoryId,
                            list: list,
                            onItemSelected: () => Navigator.of(context).pop(),
                          ),
                        );
                      }
                    );
                  },
                  child: Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(
                        width: 1,
                        color: Color(0xff1f80a9),
                      ),
                    ),
                    child: Text(
                      'اختر القسم الفرعي',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: Color(0xff1f80a9),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async{
                    final rawData = await Provider.of<MainCategoriesService>(context, listen: false).getAreas();
                    final data = json.decode(rawData.bodyString);
                    final List list = data['data'];
                    showDialog(context: context,
                        builder: (context){
                          return AlertDialog(
                            titlePadding: EdgeInsets.all(0.0),
                            contentPadding: EdgeInsets.all(0.0),
                            title: Container(
                              padding: EdgeInsets.all(10.0),
                              color: Color(0xff1f80a9),
                              child: Text('اختر القسم الفرعي',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            content: _AreasItems(
                              mainCategoryId: mainCategoryId,
                              list: list,
                              onItemSelected: (value) {
                                _areaId = value;
                                Navigator.of(context).pop();
                              },
                            ),
                          );
                        }
                    );
                  },
                  child: Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(
                        width: 1,
                        color: Color(0xff1f80a9),
                      ),
                    ),
                    child: Text(
                      'اختر المنطقة',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: Color(0xff1f80a9),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    if( _areaId != -1){
                      final rawData = await Provider.of<MainCategoriesService>(context, listen: false).getCities(_areaId);
                      final data = json.decode(rawData.bodyString);
                      final List list = data['data'];
                      showDialog(context: context,
                          builder: (context){
                            return AlertDialog(
                              titlePadding: EdgeInsets.all(0.0),
                              contentPadding: EdgeInsets.all(0.0),
                              title: Container(
                                padding: EdgeInsets.all(10.0),
                                color: Color(0xff1f80a9),
                                child: Text('اختر المدينة',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              content: _DialogItems(
                                mainCategoryId: mainCategoryId,
                                list: list,
                                onItemSelected: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                          }
                      );
                    }

                  },
                  child: Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(
                        width: 1,
                        color: Color(0xff1f80a9),
                      ),
                    ),
                    child: Text(
                      'اختر المدينة',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: Color(0xff1f80a9),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color(0xff1f80a9),
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(
                  width: 1,
                  color: Color(0xff1f80a9),
                ),
              ),
              child: Text(
                'بحث',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class _DialogItems extends StatelessWidget {

  final int mainCategoryId;
  final List list;
  final Function() onItemSelected;

  _DialogItems({@required this.mainCategoryId, @required this.list, @required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(list.length, (index){
        return GestureDetector(
          onTap: (){
            onItemSelected();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(list[index]['name'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Cairo',
                ),
              ),
              Divider(
                color: Color(0xff1f80a9),
                thickness: 1,
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _AreasItems extends StatelessWidget {

  final int mainCategoryId;
  final List list;
  final Function(int) onItemSelected;

  _AreasItems({@required this.mainCategoryId, @required this.list, @required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(list.length, (index){
        return GestureDetector(
          onTap: (){
            onItemSelected(list[index]['id']);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(list[index]['name'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Cairo',
                ),
              ),
              Divider(
                color: Color(0xff1f80a9),
                thickness: 1,
              ),
            ],
          ),
        );
      }),
    );
  }
}

