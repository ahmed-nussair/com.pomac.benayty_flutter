import 'dart:convert';

import 'package:benayty/chopper/main_categories_service.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _items = [

      Item(title: 'مكاتب هندسية', image: 'assets/main_page/engineering_office.png', function: (){},
        length: MediaQuery.of(context).size.width / 2.3,),
      Item(title: 'توريد', image: 'assets/main_page/import.png', function: (){},
        length: MediaQuery.of(context).size.width / 2.3,),
      Item(title: 'عمالة ومقاولين', image: 'assets/main_page/labour.png', function: (){},
        length: MediaQuery.of(context).size.width / 2.3,),
      Item(title: 'حدادة ونجارة وألومنيوم وزجاج', image: 'assets/main_page/carpentry.png', function: (){},
        length: MediaQuery.of(context).size.width / 2.3,),
      Item(title: 'سيراميك ورخام وحجر', image: 'assets/main_page/marbles.png', function: (){},
        length: MediaQuery.of(context).size.width / 2.3,),
      Item(title: 'مصاعد', image: 'assets/main_page/elevators.png', function: (){},
        length: MediaQuery.of(context).size.width / 2.3,),
    ];
    return Provider(
      create: (_) => MainCategoriesService.create(),
      dispose: (_, MainCategoriesService service) => service.client.dispose(),
      child: FutureBuilder<Response>(
        future: Provider.of<MainCategoriesService>(context).getMainCategories(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            final data = json.decode(snapshot.data.bodyString);
            final List categoriesList = data['data'];
            return CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: EdgeInsets.all(8.0),
                  sliver: SliverGrid.count(
                    crossAxisCount: 2,
                    childAspectRatio: .7,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 1,
                    children: List.generate(categoriesList.length, (index){
                      return Item(title: categoriesList[index]['name'],
                        image: categoriesList[index]['imagePath'],
                        function: (){},
                        length: MediaQuery.of(context).size.width / 2.3,);
                    }),
                  ),
                )
              ],
            );
          }
          return Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Item extends StatelessWidget {

  final String title;
  final String image;
  final Function function;
  final double length;

  Item({@required this.title, @required this.image, @required this.function, this.length = 200});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: FractionalOffset(0.5, 0.5),
      children: <Widget>[
        Container(
          height: length,
          width: length,
          decoration: BoxDecoration(
            color: Color(0xff1f80a9),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        Positioned(
          top: 0.0, bottom: 0.0, left: 0.0, right: 0.0,
          child: Column(
            children: <Widget>[
              Image.asset(image),
              Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Cairo',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

