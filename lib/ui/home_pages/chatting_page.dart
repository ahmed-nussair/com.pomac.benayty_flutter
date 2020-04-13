import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../globals.dart';

class ChattingPage extends StatelessWidget {
  final String userId;

  ChattingPage({@required this.userId});

  @override
  Widget build(BuildContext context) {
    return _Body(
      userId: userId,
    );
  }
}

class _Body extends StatefulWidget {
  final String userId;

  _Body({@required this.userId});

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {

  final _messageController = TextEditingController();

  int _documentId = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('messages')
          .where('toId', whereIn: [widget.userId, Globals.token,])
          .orderBy('timestamp')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data.documents;
          _documentId = snapshot.data.documents.length;

          return Column(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: ListView(
                    children: List.generate(data.length, (index) {
                      final id = data[index].data['fromId'];
//                      if(id == widget.userId){
//                        data[index].reference.updateData({'read': true});
//                      }

                      DateTime _dateTime = DateTime.fromMicrosecondsSinceEpoch(
                          data[index].data['timestamp'] * 1000);
                      return id == widget.userId ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Bubble(
                          elevation: 10.0,
                          shadowColor: Colors.grey,
                          margin: BubbleEdges.only(top: 10),
                          alignment: Alignment.centerRight,
                          nip: BubbleNip.rightTop,
                          radius: Radius.circular(15.0),
                          color: Color(0xff1f80a9),
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * (3 / 5),
                                  child: Text(data[index].data['message'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0.0, right: 0.0,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(DateFormat.jm().format(_dateTime),
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          color: Colors.white,
                                        ),
                                      ),
                                      Icon(
                                        Icons.done_all, color: Colors.white,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                          : id == Globals.token ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Bubble(
                          elevation: 10.0,
                          shadowColor: Colors.grey,
                          margin: BubbleEdges.only(top: 10),
                          alignment: Alignment.topLeft,
                          radius: Radius.circular(15.0),
                          nip: BubbleNip.leftTop,
                          color: Colors.white,
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * (3 / 5),
                                  child: Text(data[index].data['message'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      color: Color(0xff1f80a9),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0.0, right: 0.0,
                                child: Text(DateFormat.jm().format(_dateTime),
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    color: Color(0xff1f80a9),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                          : Container();
                    }),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(Icons.camera_alt),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(Icons.keyboard_voice),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: <Widget>[
                                TextFormField(
                                  controller: _messageController,
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(width: 1),

                                    ),
                                    contentPadding: EdgeInsets.only(
                                        right: 30.0),
                                  ),
                                ),
                                Positioned(
                                  right: 0.0, top: 0.0, bottom: 0.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      child: Icon(Icons.send),
                                      onTap: () {
                                        String documentName = _documentId
                                            .toString().padLeft(10, '0');
                                        _documentId ++;
                                        Firestore.instance.collection(
                                            'messages')
                                            .document(documentName)
                                            .setData({
                                          'fromId': Globals.token,
                                          'toId': widget.userId,
                                          'message': _messageController.text,
                                          'read': false,
                                          'timestamp': DateTime
                                              .now()
                                              .millisecondsSinceEpoch
                                        });
                                        _messageController.clear();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
              ],
            ),
          );
        }
      },
    );
  }
}
