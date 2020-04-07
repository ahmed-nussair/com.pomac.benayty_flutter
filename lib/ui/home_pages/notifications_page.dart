import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    elevation: 10,
                    shadowColor: Colors.grey,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(30.0),
                          alignment: Alignment.centerRight,
                          child: Text(
                            'إعلان جديد من شركة فارما',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              color: Color(0xff1f80a9),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0.0, left: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('02:20 PM',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: Color(0xff1f80a9),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}

