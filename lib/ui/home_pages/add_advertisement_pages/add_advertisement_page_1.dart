import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddAdvertisementPage1 extends StatelessWidget {

  final Function onNextPage;

  AddAdvertisementPage1({@required this.onNextPage});

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
                          child: Text('القسم الرئيسي',
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
                          child: Text('القسم الرئيسي',
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
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(10.0),
                          child: Text('القسم الفرعي',
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
                          child: Text('القسم الفرعي',
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
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(10.0),
                          child: Text('المنطقة',
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
                          child: Text('المنطقة',
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
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(10.0),
                          child: Text('المدينة',
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
                          child: Text('المدينة',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              color: Color(0xff1f80a9),
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
            padding: const EdgeInsets.only(right: 90.0, left: 90.0,),
            child: GestureDetector(
              onTap: (){
                onNextPage();
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xff1f80a9),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('التالي',
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
    );
  }
}
