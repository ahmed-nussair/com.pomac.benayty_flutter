import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../globals.dart';
import '../login.dart';

class MessagesPage extends StatelessWidget {
  final Function(String, String) onChatting;

  MessagesPage({@required this.onChatting});

  @override
  Widget build(BuildContext context) {
    return Globals.token.isNotEmpty
        ? _Body(
      onChatting: onChatting,
    )
        : Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'قم بتسجيل الدخول حتى تتمكن من رؤية الرسائل',
            style: TextStyle(fontFamily: 'Cairo'),
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

class _Body extends StatefulWidget {
  final Function(String, String) onChatting;

  _Body({@required this.onChatting});

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('messages')
          .where('toId', isEqualTo: Globals.token)
          .where('read', isEqualTo: false)
//          .where('timestamp', isGreaterThan: Globals.chattingTimestamp)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'حدث خطأ',
              style: TextStyle(fontFamily: 'Cairo'),
            ),
          );
        }
        if (snapshot.hasData) {
          final data = snapshot.data.documents;

          return data.length > 0
              ? CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.all(8.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    List.generate(data.length, (index) {
                      final message = data[index]['message'];
                      final id = data[index]['fromId'];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FutureBuilder<DocumentSnapshot>(
                          future: Firestore.instance
                              .collection('users')
                              .document(id)
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                final data = snapshot.data.data;
//                                var t = DateTime.fromMicrosecondsSinceEpoch(1586767097797 * 1000);
//                                var u = DateTime.now().millisecondsSinceEpoch;
//                                print(u);
                                return GestureDetector(
                                  onTap: () {
                                    widget.onChatting(id, data['name']);
                                  },
                                  child: Material(
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                    elevation: 10,
                                    shadowColor: Colors.grey,
                                    child: ListTile(
                                      trailing: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            data['imageUrl']),
                                      ),
                                      title: Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          data['name'],
                                          style: TextStyle(
                                            fontFamily: 'Cairo',
                                          ),
                                        ),
                                      ),
                                      subtitle: Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          message,
                                          style: TextStyle(
                                            fontFamily: 'Cairo',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            }
                            return Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: <Widget>[
                                  CircularProgressIndicator(),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          )
              : Center(
            child: Text(
              'ليس لديك رسائل',
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
}
