import 'dart:convert';

import 'package:benayty/chopper/profile_service.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../globals.dart';
import '../login.dart';
import 'ad_item.dart';

class MyAds extends StatelessWidget {
  final Function(int, String) onItemSelected;

  MyAds({@required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Globals.token.isNotEmpty ? Provider(
      create: (_) => ProfileService.create(),
      dispose: (_, ProfileService service) => service.client.dispose(),
      child: _Body(
        onItemSelected: onItemSelected,
      ),
    ) :
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('قم بتسجيل الدخول لكي تتمكن من رؤية إعلاناتك',
            style: TextStyle(
              fontFamily: 'Cairo',
            ),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Login()));
            },
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

class _Body extends StatelessWidget {
  final Function(int, String) onItemSelected;

  _Body({@required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<ProfileService>(context).getUserAds(Globals.token),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'حدث خطأ',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 20,
                ),
              ),
            );
          }

          final data = json.decode(snapshot.data.bodyString);
          final List adsList = data['data'];

          return adsList != null && adsList.length > 0
              ? CustomScrollView(
                  slivers: <Widget>[
                    SliverPadding(
                      padding: EdgeInsets.all(8.0),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                            List.generate(adsList.length, (index) {
                          return AdItem(
                            id: adsList[index]['id'],
                            title: adsList[index]['title'],
                            createdAt: adsList[index]['created_at'],
                            imagePath: adsList[index]['imagePath'],
                            userName: adsList[index]['user']['name'],
                            onItemClicked: (value) {
                              onItemSelected(value, adsList[index]['title']);
                            },
                          );
                        })),
                      ),
                    )
                  ],
                )
              : Center(
                  child: Text(
                    'لا يوجد نتائج',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 20.0,
                      color: Color(0xff1f80a9),
                    ),
                  ),
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
    );
  }
}
