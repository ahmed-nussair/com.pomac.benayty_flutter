import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
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
                    child: ListTile(
                      trailing: CircleAvatar(
                        backgroundImage: AssetImage('assets/testad.png'),
                      ),
                      title: Container(
                        alignment: Alignment.centerRight,
                        child: Text('أحمد علي',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                      subtitle: Container(
                        alignment: Alignment.centerRight,
                        child: Text('السلام عليكم',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
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

