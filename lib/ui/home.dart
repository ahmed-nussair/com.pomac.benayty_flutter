import 'package:benayty/bloc/home_page_bloc/bloc.dart';
import 'package:benayty/ui/home_pages/home_page.dart';
import 'package:benayty/ui/home_pages/messages_page.dart';
import 'package:benayty/ui/home_pages/notifications_page.dart';
import 'package:benayty/ui/home_pages/secondary_page.dart';
import 'package:benayty/ui/home_pages/wishlist_page.dart';
import 'package:benayty/ui/my_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_pages/add_advertisement_pages/add_advertisement_page_1.dart';
import 'home_pages/add_advertisement_pages/add_advertisement_page_2.dart';

class Home extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();

  Widget _drawerItem(IconData icon, String title, Function function) {
    return GestureDetector(
      onTap: () => function(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Flexible(
              child: Text(
            title,
            style: TextStyle(fontFamily: 'Cairo', color: Color(0xff1f80a9)),
          )),
          Flexible(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: Color(0xff1f80a9),
            ),
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int _mainCategoryId = 0;
    String _mainCategoryTitle = '';

    return BlocProvider(
      create: (_) => HomePageBloc()..add(NavigateToHomePageEvent()),
      child: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          final List _drawerItems = [
            _drawerItem(Icons.home, 'اصفحة الرئيسية', () {
              BlocProvider.of<HomePageBloc>(context)
                  .add(NavigateToHomePageEvent());
              Navigator.of(context).pop();
            }),
            _drawerItem(Icons.location_on, 'المواضيع بالمدينة', () {
              Navigator.of(context).pop();
            }),
            _drawerItem(Icons.search, 'بحث', () {
              Navigator.of(context).pop();
            }),
            _drawerItem(Icons.person, 'التسجيل', () {
              Navigator.of(context).pop();
            }),
            _drawerItem(Icons.error, 'الاشتراكات', () {
              Navigator.of(context).pop();
            }),
            _drawerItem(Icons.phone, 'اتصل بنا', () {
              Navigator.of(context).pop();
            }),
            _drawerItem(Icons.exit_to_app, 'تسجيل خروج', () {
              Navigator.of(context).pop();
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
                              : state is MessagesPageState
                                  ? 'الرسائل'
                                  : state is NotificationsPageState
                                      ? 'الإشعارات'
                                      : state is AddAdvertisementPage1State ||
                                              state
                                                  is AddAdvertisementPage2State
                                          ? 'إضافة إعلان'
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
                      ? WishListPage()
                      : state is SecondaryPageState
                          ? SecondaryPage(
                              mainCategoryId: _mainCategoryId,
                              onBackPressed: () =>
                                  BlocProvider.of<HomePageBloc>(context)
                                      .add(NavigateToHomePageEvent()),
                            )
                          : state is NotificationsPageState
                              ? NotificationsPage()
                              : state is MessagesPageState
                                  ? MessagesPage()
                                  : state is AddAdvertisementPage1State
                                      ? AddAdvertisementPage1(
                                          onNextPage: () {
                                            BlocProvider.of<HomePageBloc>(
                                                    context)
                                                .add(
                                                    NavigateToAdvertiseAddingPage2());
                                          },
                                        )
                                      : state is AddAdvertisementPage2State
                                          ? AddAdvertisementPage2()
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
