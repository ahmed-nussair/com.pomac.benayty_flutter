import 'dart:convert';

import 'package:benayty/ui/home_pages/ad_item.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:benayty/chopper/advertisement_service.dart';

class SearchPage extends StatelessWidget {
  final int mainItemId;
  final int secondaryItemId;
  final int areaId;
  final int cityId;

  SearchPage(
      {@required this.mainItemId,
      @required this.secondaryItemId,
      @required this.areaId,
      @required this.cityId});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => AdvertisementService.create(),
      dispose: (_, AdvertisementService service) => service.client.dispose(),
      child: _Body(
        cityId: cityId,
        areaId: areaId,
        secondaryItemId: secondaryItemId,
        mainItemId: mainItemId,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final int mainItemId;
  final int secondaryItemId;
  final int areaId;
  final int cityId;

  _Body(
      {@required this.mainItemId,
      @required this.secondaryItemId,
      @required this.areaId,
      @required this.cityId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<AdvertisementService>(context)
          .filterAdvertisements(mainItemId, secondaryItemId, areaId, cityId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final data = json.decode(snapshot.data.bodyString);
          print(data);
          final List list = data['data'];
          return CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.all(8.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                      List.generate(list.length, (index) {
                    return AdItem(
                      title: list[index]['title'],
                      createdAt: list[index]['created_at'],
                      imagePath: list[index]['imagePath'],
                      userName: list[index]['user']['name'],
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
