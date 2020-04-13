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

class _Body extends StatefulWidget {

  final Function(int, String) onItemClicked;

  _Body({@required this.onItemClicked});

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {

  Widget _body;


  _refreshList() {
    setState(() {
      _body = FutureBuilder<Response>(
        future: Provider.of<WishListService>(context, listen: false)
            .getWishList(Globals.token),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = json.decode(snapshot.data.bodyString);
            final List wishList = data['data'];

            return wishList.length > 0 ? CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: EdgeInsets.all(8.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      List.generate(wishList.length, (index) {
                        return AdItem(
                          isWishListed: true,
                          id: wishList[index]['advertisement']['id'],
                          title: wishList[index]['advertisement']['title'],
                          createdAt: wishList[index]['advertisement']['created_at'],
                          imagePath: wishList[index]['advertisement']['imagePath'],
                          userName: wishList[index]['advertisement']['user']['name'],
                          onItemClicked: (value) {
                            widget.onItemClicked(value,
                                wishList[index]['advertisement']['title']);
                          },
                          onItemDeleted: () async {
                            await Provider.of<WishListService>(
                                context, listen: false).deleteFromWishList({
                              'token': Globals.token,
                              'advertisement_id': wishList[index]['advertisement']['id'],
                            });
                            _refreshList();
                          },
                        );
                      }),
                    ),
                  ),
                ),
              ],
            )
                : Center(
              child: Text('ليس لديك أي إعلان في المفضلة',
                style: TextStyle(
                  fontFamily: 'Cairo',
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
    });
  }

  @override
  void initState() {
    super.initState();
    _body = FutureBuilder<Response>(
      future: Provider.of<WishListService>(context, listen: false).getWishList(
          Globals.token),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = json.decode(snapshot.data.bodyString);
          final List wishList = data['data'];
          return wishList.length > 0 ? CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.all(8.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    List.generate(wishList.length, (index) {
                      return AdItem(
                        isWishListed: true,
                        id: wishList[index]['advertisement']['id'],
                        title: wishList[index]['advertisement']['title'],
                        createdAt: wishList[index]['advertisement']['created_at'],
                        imagePath: wishList[index]['advertisement']['imagePath'],
                        userName: wishList[index]['advertisement']['user']['name'],
                        onItemClicked: (value) {
                          widget.onItemClicked(
                              value, wishList[index]['advertisement']['title']);
                        },
                        onItemDeleted: () async {
                          await Provider.of<WishListService>(
                              context, listen: false).deleteFromWishList({
                            'token': Globals.token,
                            'advertisement_id': wishList[index]['advertisement']['id'],
                          });
                          _refreshList();
                        },
                      );
                    }),
                  ),
                ),
              ),
            ],
          )
              : Center(
            child: Text('ليس لديك أي إعلان في المفضلة',
              style: TextStyle(
                fontFamily: 'Cairo',
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

  @override
  Widget build(BuildContext context) {
    return _body;
  }
}