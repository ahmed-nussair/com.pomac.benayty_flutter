import 'dart:convert';

import 'package:benayty/chopper/main_categories_service.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondaryPage extends StatelessWidget {

  final int mainCategoryId;

  SecondaryPage({@required this.mainCategoryId});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => MainCategoriesService.create(),
      dispose: (_, MainCategoriesService service) => service.client.dispose(),
      child: _SecondaryPageBody(
        mainCategoryId: mainCategoryId,
      ),
    );
//    return FutureBuilder<Response>(
//      future: Provider.of<MainCategoriesService>(context).getSecondaryCategories(mainCategoryId),
//      builder: (context, snapshot){
//
//        if(snapshot.connectionState == ConnectionState.done){
//          final data = json.decode(snapshot.data.bodyString);
//          final List categoriesList = data['data'];
//        }
//        return Container(
//          alignment: Alignment.center,
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              CircularProgressIndicator(),
//            ],
//          ),
//        );
//      },
//    );
  }
}

class _SecondaryPageBody extends StatelessWidget {

  final int mainCategoryId;

  _SecondaryPageBody({@required this.mainCategoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                  child: Text('اختر القسم الفرعي',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: Color(0xff1f80a9),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                  child: Text('اختر المنطقة',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: Color(0xff1f80a9),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                  child: Text('اختر المدينة',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: Color(0xff1f80a9),
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
              child: Text('بحث',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}

