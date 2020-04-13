import 'dart:convert';

import 'package:benayty/chopper/wishlist_service.dart';
import 'package:benayty/ui/home_pages/ad_item.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../globals.dart';

class WishListPage extends StatelessWidget {

  final Function(int, String) onItemClicked;

  WishListPage({@required this.onItemClicked});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => WishListService.create(),
      dispose: (_, WishListService service) => service.client.dispose(),
      child: _Body(
        onItemClicked: onItemClicked,
      ),
    );
  }
}

class _Body extends StatelessWidget {

  final Function(int, String) onItemClicked;

  _Body({@required this.onItemClicked});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<WishListService>(context).getWishList(Globals.token),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final data = json.decode(snapshot.data.bodyString);
          final List wishList = data['data'];
          return CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.all(8.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    List.generate(wishList.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          onItemClicked(wishList[index]['advertisement']['id'],
                              wishList[index]['advertisement']['title']);
                        },
                        child: AdItem(
                            title: wishList[index]['advertisement']['title'],
                            createdAt: wishList[index]['advertisement']['created_at'],
                            imagePath: wishList[index]['advertisement']['imagePath'],
                            userName: wishList[index]['advertisement']['user']['name']),
                      );
                    }),
                  ),
                ),
              ),
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
