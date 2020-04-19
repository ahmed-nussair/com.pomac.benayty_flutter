import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../globals.dart';
import '../login.dart';
import '../my_icons.dart';
import 'package:benayty/chopper/advertisement_service.dart';

class AdDescription extends StatelessWidget {
  final int adId;
  final Function(int, String) onDisplayUserAds;
  final Function(String, String) onMessage;
  final bool openedFromUserAds;

  AdDescription(
      {@required this.adId, @required this.onMessage, @required this.onDisplayUserAds, this.openedFromUserAds = false});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => AdvertisementService.create(),
      dispose: (_, AdvertisementService service) => service.client.dispose(),
      child: _Body(
        adId: adId,
        onDisplayUserAds: onDisplayUserAds,
        onMessage: onMessage,
        openedFromUserAds: openedFromUserAds,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final int adId;
  final Function(int, String) onDisplayUserAds;
  final Function(String, String) onMessage;
  final bool openedFromUserAds;

  _Body(
      {@required this.adId, @required this.onMessage, @required this.onDisplayUserAds, this.openedFromUserAds = false});

  Widget _adButton(IconData icon, Function function, String tooltipMessage) {
    return Tooltip(
      message: tooltipMessage,
      child: GestureDetector(
        onTap: () {
          function();
        },
        child: Container(
          padding: EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
            left: 20.0,
            right: 20.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Color(0xff1f80a9),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: Color(0xff1f80a9),
          ),
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text(
          'قم بتسجيل الدخول حتى يمكنك القيام بهذه العملية',
          style: TextStyle(
            fontFamily: 'Cairo',
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Text('إغلاق'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text('تسجيل الدخول'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response>(
      future:
      Provider.of<AdvertisementService>(context).showAdvertisement(adId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.data.isSuccessful) {
            return Center(
              child: Text(
                'حدث خطأ',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 20,
                  color: Color(0xff1f80a9),
                ),
              ),
            );
          }
          final theData = json.decode(snapshot.data.bodyString);
          final Map data = theData['data'];
          final List commentsList = data['comments'];
//          print(commentsList);

          return Scaffold(
            resizeToAvoidBottomPadding: false,
            resizeToAvoidBottomInset: false,
            body: Column(
              children: <Widget>[
                openedFromUserAds == false ? GestureDetector(
                  onTap: () {
                    onDisplayUserAds(
                        int.parse(data['user_id']), data['user']['name']);
                  },
                  child: Material(
                    elevation: 10,
                    shadowColor: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                data['phone'],
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: Color(0xff1f80a9),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                              ),
                              Icon(
                                Icons.phone,
                                color: Color(0xff1f80a9),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                data['area'],
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: Color(0xff1f80a9),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                              ),
                              Icon(
                                Icons.location_on,
                                color: Color(0xff1f80a9),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                data['user']['name'],
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: Color(0xff1f80a9),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                              ),
                              Icon(
                                Icons.person,
                                color: Color(0xff1f80a9),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ) : Container(),
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      children: <Widget>[
                        // Ad Description
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data['description'],
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              color: Color(0xff1f80a9),
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),

                        // Ad image
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              data['imagePath'],
                            ),
                          ),
                        ),

                        // Ad buttons
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 40.0,
                            right: 40.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Add comment
                              _adButton(Icons.comment, () {
                                if (Globals.token.isNotEmpty) {
                                  // add a comment
                                  showDialog(
                                    context: context,
                                    child: _AddingComment(
                                      onAddingComment: (value) async {
                                        var response = await Provider.of<
                                            AdvertisementService>(
                                          context,
                                          listen: false,
                                        ).addComment({
                                          'token': Globals.token,
                                          'advertisement_id': '$adId',
                                          'comment': value,
                                        });
                                        print(response.bodyString);
                                        final data =
                                        json.decode(response.bodyString);
                                        Fluttertoast.showToast(
                                            msg: data['message'],
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.grey,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      },
                                    ),
                                  );
                                } else {
                                  _showDialog(context);
                                }
                              }, 'أضف تعليقًا'),

                              // Add to wishlist
                              _adButton(Icons.favorite_border, () async {
                                String _result = '';
                                bool done = false;
                                if (Globals.token.isNotEmpty) {
                                  final response =
                                  await Provider.of<AdvertisementService>(
                                      context,
                                      listen: false)
                                      .addToWishList({
                                    'token': Globals.token,
                                    'advertisement_id': '$adId',
                                  });

                                  final data = json.decode(response.bodyString);

                                  if (data['status'] == 200) {
                                    _result = data['message'];
                                    done = true;
                                  } else {
                                    _result = data['errors'][0];
                                  }

                                  showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      title: Stack(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Text(
                                              _result,
                                              style: TextStyle(
                                                fontFamily: 'Cairo',
                                                color: Color(0xff1f80a9),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: 0.0,
                                            top: 0.0,
                                            child: done &&
                                                Globals.token.isNotEmpty
                                                ? CircleAvatar(
                                              backgroundColor:
                                              Colors.green,
                                              child: Icon(
                                                Icons.done,
                                                color: Colors.white,
                                              ),
                                            )
                                                : CircleAvatar(
                                              backgroundColor: Colors.red,
                                              child: Icon(
                                                Icons.clear,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'إغلاق',
                                            ),
                                          ),
                                        ),
                                        Globals.token.isEmpty
                                            ? Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                          Login()));
                                            },
                                            child: Text(
                                              'تسجيل الدخول',
                                            ),
                                          ),
                                        )
                                            : Container(),
                                      ],
                                    ),
                                  );
                                } else {
                                  _showDialog(context);
                                }
                              }, 'أضف إلى المفضلة'),

//                              // Share ad
//                              _adButton(Icons.share, () {
//                                print('Share Icon Clicked');
//                              }),

                              // Message to ad owner
                              _adButton(MyIcons.comment_empty, () {
                                if (Globals.token.isNotEmpty) {
                                  onMessage('${data['user_id']}',
                                      data['user']['name']);
                                } else {
                                  _showDialog(context);
                                }
                              }, 'مراسلة صاحب الإعلان'),
                            ],
                          ),
                        ),

                        // Comments title
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                'التعليقات',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: Color(0xff1f80a9),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                              ),
                              Icon(
                                Icons.comment,
                                color: Color(0xff1f80a9),
                              ),
                            ],
                          ),
                        ),

                        Divider(),

                        // comments
                        commentsList != null ? Column(
                          children: List.generate(commentsList.length, (index) {
                            return Column(
                              children: <Widget>[
                                ListTile(
                                  trailing: FutureBuilder<bool>(
                                    future: Globals.isImageUrlWell(
                                        commentsList[index]['imagePath']),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        bool isGoodImageUrl = snapshot.data;

                                        if (isGoodImageUrl) {
                                          return CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                commentsList[index]
                                                ['imagePath']),
                                          );
                                        }

                                        return CircleAvatar(
                                          backgroundImage: AssetImage(
                                              'assets/default_user.png'),
                                        );
                                      }
                                      return CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/default_user.png'),
                                      );
                                    },
                                  ),
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          commentsList[index]['user']['name'],
                                          style: TextStyle(
                                            fontFamily: 'Cairo',
                                            color: Color(0xff1f80a9),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          commentsList[index]['comment'],
                                          style: TextStyle(
                                            fontFamily: 'Cairo',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                              ],
                            );
                          }),
                        ) : Container(),
                      ],
                    ),
                  ),
                ),
              ],
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

class _AddingComment extends StatefulWidget {
  final Function(String) onAddingComment;

  _AddingComment({@required this.onAddingComment});

  @override
  _AddingCommentState createState() => _AddingCommentState();
}

class _AddingCommentState extends State<_AddingComment> {
  final _commentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          textAlign: TextAlign.end,
          maxLines: 4,
          controller: _commentTextController,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: 'اكتب تعليقاً',
            hintStyle: TextStyle(
              fontFamily: 'Cairo',
            ),
            contentPadding: EdgeInsets.all(5.0),
          ),
        ),
      ),
      actions: <Widget>[
        // close
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'إلغاء',
              style: TextStyle(
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ),

        // add comment
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              widget.onAddingComment(_commentTextController.text);
            },
            child: Text(
              'أضف التعليق',
              style: TextStyle(
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
