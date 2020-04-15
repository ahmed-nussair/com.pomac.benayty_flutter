import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:benayty/chopper/advertisement_service.dart';

import 'ad_item.dart';

class UserAds extends StatelessWidget {
  final int userId;
  final Function(int, String) onItemSelected;

  UserAds({
    @required this.userId,
    @required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => AdvertisementService.create(),
      dispose: (_, AdvertisementService service) => service.client.dispose(),
      child: _Body(
        userId: userId,
        onItemSelected: onItemSelected,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final int userId;
  final Function(int, String) onItemSelected;

  _Body({
    @required this.userId,
    @required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<AdvertisementService>(context).getUserAds(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'حدث خطأ',
                style: TextStyle(
                  fontFamily: 'Cairo',
                ),
              ),
            );
          }

          final data = json.decode(snapshot.data.bodyString);
          final List list = data['data'];

          return CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.all(8.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                      List.generate(list.length, (index) {
                    return AdItem(
                      id: list[index]['id'],
                      title: list[index]['title'],
                      createdAt: list[index]['created_at'],
                      imagePath: list[index]['imagePath'],
                      userName: list[index]['user']['name'],
                      onItemClicked: (value) {
                        onItemSelected(value, list[index]['title']);
                      },
                    );
                  })),
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
    );
  }
}
