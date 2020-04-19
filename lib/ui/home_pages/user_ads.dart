import 'dart:convert';

import 'package:benayty/bloc/rating_bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:benayty/chopper/advertisement_service.dart';

import 'ad_item.dart';

class UserAds extends StatelessWidget {
  final int userId;
  final Function(int, String) onItemSelected;

  UserAds({
    @required this.userId,
    @required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => AdvertisementService.create(),
      dispose: (_, AdvertisementService service) => service.client.dispose(),
      child: _Body(
        userId: userId,
        onItemSelected: onItemSelected,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final int userId;
  final Function(int, String) onItemSelected;

  _Body({
    @required this.userId,
    @required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<AdvertisementService>(context).getUserAds(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'حدث خطأ',
                style: TextStyle(
                  fontFamily: 'Cairo',
                ),
              ),
            );
          }

          final data = json.decode(snapshot.data.bodyString);
          final List list = data['data'];

//          bool _ratedUp = false;
//          bool _retedDown = false;

          return Column(
            children: <Widget>[
              Material(
                elevation: 10,
                shadowColor: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
//                      Row(
//                        children: <Widget>[
//                          Text(
//                            'متابعة',
//                            style: TextStyle(
//                              fontFamily: 'Cairo',
//                              color: Color(0xff1f80a9),
//                            ),
//                          ),
//                          Padding(
//                            padding: EdgeInsets.all(1.0),
//                          ),
//                          Icon(
//                            Icons.rss_feed,
//                            color: Color(0xff1f80a9),
//                          ),
//                        ],
//                      ),

                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.thumb_up,
                            color: Colors.green,
                          ),
                          Padding(
                            padding: EdgeInsets.all(2.0),
                          ),
                          Text('1'),
                          Padding(
                            padding: EdgeInsets.all(3.0),
                          ),
                          Icon(
                            Icons.thumb_down,
                            color: Colors.red,
                          ),
                          Padding(
                            padding: EdgeInsets.all(2.0),
                          ),
                          Text('1'),
                          Padding(
                            padding: EdgeInsets.all(5.0),
                          ),
                          Text(
                            'تقييم',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              color: Color(0xff1f80a9),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 50.0, left: 10.0),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'مراسلة',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              color: Color(0xff1f80a9),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(1.0),
                          ),
                          Icon(
                            Icons.mail,
                            color: Color(0xff1f80a9),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 30.0,),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: list != null && list.length > 0 ?
                  CustomScrollView(
                    slivers: <Widget>[
                      SliverPadding(
                        padding: EdgeInsets.all(8.0),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate(
                              List.generate(list.length, (index) {
                                return AdItem(
                                  id: list[index]['id'],
                                  title: list[index]['title'],
                                  createdAt: list[index]['created_at'],
                                  imagePath: list[index]['imagePath'],
                                  userName: list[index]['user']['name'],
                                  onItemClicked: (value) {
                                    onItemSelected(value, list[index]['title']);
                                  },
                                );
                              })),
                        ),
                      )
                    ],
                  )
                      : Center(
                    child: Text('ليس لهذا المستخدم أي إعلان',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                      ),
                    ),
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

class Rating extends StatefulWidget {

  final Function(int, String) onRated;

  Rating({@required this.onRated});

  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {

  int _ratingValue = 1;
  String _review = '';

  final _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      RatingBloc()
        .. add(GiveOneStarEvent()),
      child: BlocBuilder<RatingBloc, RatingState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(

                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('تقييم',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 4.0, bottom: 8.0,),
                            child: Divider(
                              color: Colors.black,
                              thickness: 1,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _ratingValue = 1;
                                  BlocProvider.of<RatingBloc>(context).add(
                                      GiveOneStarEvent());
                                },
                                child: state is OneStarState ||
                                    state is TwoStarState ||
                                    state is ThreeStarState ||
                                    state is FourStarState ||
                                    state is FiveStarState ?
                                Image.asset('assets/star1.png', scale: 5,) :
                                Image.asset('assets/star2.png', scale: 5,),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _ratingValue = 2;
                                  BlocProvider.of<RatingBloc>(context).add(
                                      GiveTwoStarEvent());
                                },
                                child: state is TwoStarState ||
                                    state is ThreeStarState ||
                                    state is FourStarState ||
                                    state is FiveStarState ?
                                Image.asset('assets/star1.png', scale: 5,) :
                                Image.asset('assets/star2.png', scale: 5,),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _ratingValue = 3;
                                  BlocProvider.of<RatingBloc>(context).add(
                                      GiveThreeStarEvent());
                                },
                                child: state is ThreeStarState ||
                                    state is FourStarState ||
                                    state is FiveStarState ?
                                Image.asset('assets/star1.png', scale: 5,) :
                                Image.asset('assets/star2.png', scale: 5,),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _ratingValue = 4;
                                  BlocProvider.of<RatingBloc>(context).add(
                                      GiveFourStarEvent());
                                },
                                child: state is FourStarState ||
                                    state is FiveStarState ?
                                Image.asset('assets/star1.png', scale: 5,) :
                                Image.asset('assets/star2.png', scale: 5,),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _ratingValue = 5;
                                  BlocProvider.of<RatingBloc>(context).add(
                                      GiveFiveStarEvent());
                                },
                                child: state is FiveStarState ?
                                Image.asset('assets/star1.png', scale: 5,) :
                                Image.asset('assets/star2.png', scale: 5,),
                              ),
                            ],
                          ),

//                Padding(
//                  padding: EdgeInsets.all(10.0),
//                ),

                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              textAlign: TextAlign.right,
                              maxLines: 5,
                              controller: _reviewController,
                              decoration: InputDecoration(
                                hintText: 'أضف تعليق',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RaisedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('إلغاء',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                              ),
                              RaisedButton(
                                onPressed: () {
                                  _review = _reviewController.text;
                                  _reviewController.clear();
                                  Navigator.of(context).pop();
                                  widget.onRated(_ratingValue, _review);
                                },
                                child: Text('أرسل التقييم',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}


