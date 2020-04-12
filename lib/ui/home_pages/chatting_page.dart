import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Chatting Page'),
    );
  }
}
