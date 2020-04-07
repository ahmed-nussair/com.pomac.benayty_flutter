import 'package:benayty/ui/home_pages/ad_description.dart';
import 'package:benayty/ui/home_pages/ad_item.dart';
import 'package:flutter/material.dart';

class WishListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Body();
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.all(8.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              List.generate(10, (index) {
                return AdItem(
                    title: 'اسم الإعلان',
                    createdAt: '',
                    imagePath:
                    'http://pomac.info/benaity/public/uploads/specialists/04-2020/926.080412.png',
                    userName: 'أحمد');
              }),
            ),
          ),
        ),
      ],
    );
  }
}
