import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../globals.dart';
import '../my_icons.dart';
import 'package:benayty/chopper/advertisement_service.dart';

class AdDescription extends StatelessWidget {
  final int adId;

  AdDescription({@required this.adId});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => AdvertisementService.create(),
      dispose: (_, AdvertisementService service) => service.client.dispose(),
      child: _Body(
        adId: adId,
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final int adId;

  _Body({@required this.adId});

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  final _addIcons = [
    Icons.favorite,
    Icons.comment,
    Icons.share,
    MyIcons.comment,
  ];

  final _commentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<AdvertisementService>(context)
          .showAdvertisement(widget.adId),
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
                Material(
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
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      children: <Widget>[
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              data['imagePath'],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 40.0,
                            right: 40.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(_addIcons.length, (index) {
                              return Container(
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
                                  _addIcons[index],
                                  color: Color(0xff1f80a9),
                                ),
                              );
                            }),
                          ),
                        ),
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
                        ListTile(
                          trailing: CircleAvatar(
                            backgroundImage: AssetImage('assets/testad.png'),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'محمد حسن الراعي',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    color: Color(0xff1f80a9),
                                  ),
                                ),
                              ),
                              TextFormField(
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
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(commentsList.length, (index) {
                            return ListTile(
                              trailing: FutureBuilder(
                                future: Globals.isImageUrlWell(
                                    commentsList[index]['imagePath']),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasData) {
                                      bool isGoodImageUrl = snapshot.data;

                                      if (isGoodImageUrl) {
                                        return CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              commentsList[index]['imagePath']),
                                        );
                                      }
                                      return SizedBox(
                                        child: Icon(Icons.error),
                                        width: 30,
                                        height: 30,
                                      );
                                    }
                                    return SizedBox(
                                      child: Icon(Icons.error),
                                      width: 30,
                                      height: 30,
                                    );
                                  }
                                  return CircularProgressIndicator();
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
                                  Text(
                                    commentsList[index]['comment'],
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
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
