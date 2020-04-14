import 'package:benayty/bloc/home_page_bloc/bloc.dart';
import 'package:benayty/ui/home_pages/chatting_page.dart';
import 'package:benayty/ui/home_pages/home_page.dart';
import 'package:benayty/ui/home_pages/messages_page.dart';
import 'package:benayty/ui/home_pages/my_ads.dart';
import 'package:benayty/ui/home_pages/notifications_page.dart';
import 'package:benayty/ui/home_pages/search_page.dart';
import 'package:benayty/ui/home_pages/secondary_page.dart';
import 'package:benayty/ui/home_pages/wishlist_page.dart';
import 'package:benayty/ui/my_icons.dart';
import 'package:benayty/ui/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart';
import 'home_pages/ad_description.dart';
import 'home_pages/add_advertisement_pages/add_advertisement_page_1.dart';
import 'home_pages/add_advertisement_pages/add_advertisement_page_2.dart';
import 'home_pages/contact_us.dart';
import 'login.dart';

class Home extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();

  Widget _drawerItem(IconData icon, String title, Function function) {
    return GestureDetector(
      onTap: () => function(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontFamily: 'Cairo', color: Color(0xff1f80a9)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: Color(0xff1f80a9),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int _mainCategoryId = 0;
    String _mainCategoryTitle = '';
    String _adName = '';

    int _mainItemIdForAdAdded = -1;
    int _secondaryItemIdForAdAdded = -1;
    int _areaIdForAdAdded = -1;
    int _cityIdForAdAdded = -1;

    int _mainItemIdForSearch = -1;
    int _secondaryItemIdForSearch = -1;
    int _areaIdForSearch = -1;
    int _cityIdForSearch = -1;

    int _adId = -1;

    String _userIdForChatting = '';
    String _userNameForChatting = '';

    return BlocProvider(
      create: (_) => HomePageBloc()..add(NavigateToHomePageEvent()),
      child: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          List _drawerItems = [
            _drawerItem(Icons.home, 'اصفحة الرئيسية', () {
              BlocProvider.of<HomePageBloc>(context)
                  .add(NavigateToHomePageEvent());
              Navigator.of(context).pop();
            }),
            _drawerItem(Icons.search, 'إعلاناتي', () {
              Navigator.of(context).pop();
              BlocProvider.of<HomePageBloc>(context)
                  .add(NavigateToMyAdsPageEvent());
            }),
            _drawerItem(Icons.person, 'التسجيل', () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Register()));
            }),
            _drawerItem(Icons.favorite_border, 'المفضله', () {
              Navigator.of(context).pop();
              BlocProvider.of<HomePageBloc>(context)
                  .add(NavigateToWishListPageEvent());
            }),
//            _drawerItem(Icons.phone, 'اتصل بنا', () {
//              BlocProvider.of<HomePageBloc>(context)
//                  .add(NavigateToContactUsPage());
//              Navigator.of(context).pop();
//            }),
            _drawerItem(
                Icons.exit_to_app, 'تسجيل الدخول / الخروج', () async {
              Navigator.of(context).pop();
              if (Globals.token.isEmpty) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Login()));
              } else {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                await prefs.remove('token');
                await prefs.remove('userName');
                await prefs.remove('userPhone');
                await prefs.remove('userImagePath');

                Globals.token = '';

                Fluttertoast.showToast(
                    msg: 'تم تسجيل خروجك',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }
            }),
          ];
          return SafeArea(
            child: Scaffold(
              key: _key,
              endDrawer: Drawer(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Image.asset(
                        'assets/logo.png',
                      ),
                      alignment: Alignment.topCenter,
                    ),
                    Expanded(
                      child: SizedBox(
                        width: 300,
                        child: ListView(
                          children: List.generate(_drawerItems.length, (index) {
                            return _drawerItems[index];
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              appBar: AppBar(
                leading: state is SecondaryPageState ||
                        state is AddAdvertisementPage1State ||
                        state is AddAdvertisementPage2State
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          child: Icon(Icons.arrow_back_ios),
                          onTap: () => BlocProvider.of<HomePageBloc>(context)
                              .add(NavigateToHomePageEvent()),
                        ),
                      )
                    : state is AdDescriptionState
                    ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Icon(Icons.arrow_back_ios),
                    onTap: () =>
                        BlocProvider.of<HomePageBloc>(context)
                            .add(EventsStack.pop()),
                  ),
                )
                    : state is ChattingPageState
                    ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Icon(Icons.arrow_back_ios),
                    onTap: () =>
                        BlocProvider.of<HomePageBloc>(context)
                            .add(EventsStack.pop()),
                  ),
                )
                    : Container(),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        _key.currentState.openEndDrawer();
                      },
                      child: Icon(Icons.dehaze),
                    ),
                  ),
                ],
                centerTitle: true,
                title: Text(
                  state is MainPageState
                      ? 'الرئيسية'
                      : state is SecondaryPageState
                          ? _mainCategoryTitle
                          : state is WishListPageState
                              ? 'المفضلة'
                      : state is ContactUsState
                      ? 'اتصل بنا'
                      : state is MyAdsPageState
                      ? 'إعلاناتي'
                      : state is MessagesPageState
                      ? 'الرسائل'
                      : state is ChattingPageState
                      ? _userNameForChatting
                      : state is NotificationsPageState
                      ? 'الإشعارات'
                      : state is AddAdvertisementPage1State ||
                      state
                      is AddAdvertisementPage2State
                      ? 'إضافة إعلان'
                      : state is SearchPageState
                      ? 'نتائج البحث'
                      : state is AdDescriptionState
                      ? _adName
                      : '',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
              body: state is MainPageState
                  ? HomePage(
                      showSecondaryCategoriesFunction:
                          (int value, String title) {
                        _mainCategoryId = value;
                        _mainCategoryTitle = title;
                        BlocProvider.of<HomePageBloc>(context)
                            .add(NavigateToSecondaryPageEvent());
                      },
                    )
                  : state is WishListPageState
                  ? WishListPage(
                onItemClicked: (id, title) {
                  _adId = id;
                  _adName = title;
                  EventsStack.push(NavigateToWishListPageEvent());
                  BlocProvider.of<HomePageBloc>(context)
                      .add(NavigateToAdDescription());
                },
              )
                  : state is ContactUsState
                  ? ContactUs()
                  : state is SearchPageState
                  ? SearchPage(
                mainItemId: _mainItemIdForSearch,
                secondaryItemId: _secondaryItemIdForSearch,
                areaId: _areaIdForSearch,
                cityId: _cityIdForSearch,
                onItemSelected: (id, title) {
                  _adId = id;
                  _adName = title;
                  EventsStack.push(NavigateToSearchPageEvent());
                  BlocProvider.of<HomePageBloc>(context)
                      .add(NavigateToAdDescription());
                },
              )
                  : state is SecondaryPageState
                  ? SecondaryPage(
                mainCategoryId: _mainCategoryId,
                onSearch: (mainId, secondaryId, areaId,
                    cityId) {
                  _mainItemIdForSearch = mainId;
                  _secondaryItemIdForSearch = secondaryId;
                  _areaIdForSearch = areaId;
                  _cityIdForSearch = cityId;
                  BlocProvider.of<HomePageBloc>(context)
                      .add(NavigateToSearchPageEvent());
                },
                onBackPressed: () =>
                    BlocProvider.of<HomePageBloc>(context)
                        .add(NavigateToHomePageEvent()),
              )
                  : state is NotificationsPageState
                  ? NotificationsPage()
                  : state is MessagesPageState
                  ? MessagesPage(
                onChatting: (userId, userName) {
                  _userIdForChatting = userId;
                  _userNameForChatting = userName;
                  EventsStack.push(NavigateToMessagesPageEvent());
                  BlocProvider.of<HomePageBloc>(
                      context)
                      .add(
                      NavigateToChattingPageEvent());
                },
              )
                  : state is AddAdvertisementPage1State
                  ? AddAdvertisementPage1(
                onNextPage: (int mainItemId,
                    int secondaryItemId,
                    int areaId,
                    int cityId) {
                  _mainItemIdForAdAdded =
                      mainItemId;
                  _secondaryItemIdForAdAdded =
                      secondaryItemId;
                  _areaIdForAdAdded = areaId;
                  _cityIdForAdAdded = cityId;

                  BlocProvider.of<
                      HomePageBloc>(
                      context)
                      .add(
                      NavigateToAdvertiseAddingPage2());
                },
              )
                  : state is AddAdvertisementPage2State
                  ? AddAdvertisementPage2(
                mainItemId:
                _mainItemIdForAdAdded,
                secondaryItemId:
                _secondaryItemIdForAdAdded,
                areaId: _areaIdForAdAdded,
                cityId: _cityIdForAdAdded,
                onSentSuccessfully: () {
                  BlocProvider.of<
                      HomePageBloc>(
                      context)
                      .add(
                      NavigateToHomePageEvent());
                },
              )
                  : state is AdDescriptionState
                  ? AdDescription(
                adId: _adId,
                onMessage: (userId,
                    userName) {
                  _userIdForChatting =
                      userId;
                  _userNameForChatting =
                      userName;
                  EventsStack.push(NavigateToAdDescription());
                  BlocProvider.of<
                      HomePageBloc>(
                      context)
                      .add(
                      NavigateToChattingPageEvent());
                },
              )
                  : state is ChattingPageState
                  ? ChattingPage(
                userId:
                _userIdForChatting,
              )
                  : state is MyAdsPageState ?
              MyAds(onItemSelected: (id, title) {
                _adId = id;
                _adName = title;
                EventsStack.push(NavigateToSearchPageEvent());
                BlocProvider.of<HomePageBloc>(context)
                    .add(NavigateToAdDescription());
              })
                  : Container(),
              bottomNavigationBar: Stack(
                overflow: Overflow.visible,
                alignment: FractionalOffset(0.5, 1.0),
                children: [
                  Container(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              GestureDetector(
                                child: state is MessagesPageState
                                    ? Container(
                                        padding: EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          color: Color(0xff1f80a9),
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        child: Icon(
                                          MyIcons.comment,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Icon(
                                        MyIcons.comment_empty,
                                        color: Color(0xff1f80a9),
                                      ),
                                onTap: () {
                                  BlocProvider.of<HomePageBloc>(context)
                                      .add(NavigateToMessagesPageEvent());
                                },
                              ),
                              GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<HomePageBloc>(context).add(
                                        NavigateToNotificationsPageEvent());
                                  },
                                  child: state is NotificationsPageState
                                      ? Container(
                                          padding: EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                            color: Color(0xff1f80a9),
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          child: Icon(
                                            Icons.notifications,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Icon(
                                          Icons.notifications_none,
                                          color: Color(0xff1f80a9),
                                        )),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  BlocProvider.of<HomePageBloc>(context)
                                      .add(NavigateToWishListPageEvent());
                                },
                                child: state is WishListPageState
                                    ? Container(
                                        padding: EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          color: Color(0xff1f80a9),
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Icon(
                                        Icons.favorite_border,
                                        color: Color(0xff1f80a9),
                                      ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  BlocProvider.of<HomePageBloc>(context)
                                      .add(NavigateToHomePageEvent());
                                },
                                child: state is MainPageState
                                    ? Container(
                                        padding: EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          color: Color(0xff1f80a9),
                                        ),
                                        child: Icon(
                                          Icons.home,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Icon(
                                        MyIcons.home_outline,
                                        color: Color(0xff1f80a9),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 6.0,
                            spreadRadius: 3),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Material(
                      color: Colors.transparent,
                      type: MaterialType.button,
                      borderOnForeground: true,
                      elevation: 10,
                      borderRadius: BorderRadius.circular(20),
                      shadowColor: Colors.grey,
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue,
                        elevation: 100,
                        onPressed: () {
                          if (!(state is AddAdvertisementPage1State) &&
                              !(state is AddAdvertisementPage2State)) {
                            BlocProvider.of<HomePageBloc>(context)
                                .add(NavigateToAdvertiseAddingPage1());
                          }
                        },
                        child: new Icon(
                          Icons.add,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
