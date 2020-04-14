import 'package:benayty/ui/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

import '../globals.dart';
import 'home.dart';
import 'login.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _scaleController;
  AnimationController _paddingController;
  AnimationController _loginController;
  AnimationController _registerController;
  AnimationController _skipController;

  Animation _animation;
  Animation _scaleAnimation;
  Animation _paddingAnimation;
  Animation _loginAnimation;
  Animation _registerAnimation;
  Animation _skipAnimation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _scaleController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _paddingController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _loginController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _registerController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _skipController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.linear))
      ..addStatusListener((status) async {
      if(status == AnimationStatus.completed){
//        SharedPreferences prefs = await SharedPreferences.getInstance();
//
//        String token = prefs.getString('token') ?? '';
//        Globals.token = token;

        Timer(Duration(seconds: 1), () =>
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Home())));
//        _scaleController.forward();
//        _paddingController.forward();
      }
    });
    
    _scaleAnimation = Tween(begin: 1.0, end: 0.75).animate(CurvedAnimation(parent: _scaleController, curve: Curves.linear));

    _paddingAnimation = Tween(begin: 50.0, end: 0.0).animate(CurvedAnimation(parent: _paddingController, curve: Curves.linear))
      ..addStatusListener((status){
        if(status == AnimationStatus.completed){
          _loginController.forward();
        }
      });

    _loginAnimation = Tween(begin: 500.0, end: 0.0).animate(CurvedAnimation(parent: _loginController, curve: Curves.linear))
    ..addStatusListener((status){
      if(status == AnimationStatus.completed){
        _registerController.forward();
      }
    });

    _registerAnimation = Tween(begin: 500.0, end: 0.0).animate(CurvedAnimation(parent: _registerController, curve: Curves.linear))
      ..addStatusListener((status){
        if(status == AnimationStatus.completed){
          _skipController.forward();
        }
      });

    _skipAnimation = Tween(begin: 500.0, end: 0.0).animate(CurvedAnimation(parent: _skipController, curve: Curves.linear));

    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    final Map<String, Function> splashButtons =
    {'تسجيل الدخول':() => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Login(onLogin: () =>
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home())),))),
    'التسجيل': () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Register(
      onRegistered: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home())),
    ))),
    'التخطي': () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()))};
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset('assets/splash_background.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
          ),
          AnimatedBuilder(
            animation: _paddingAnimation,
            builder: (context, child){
              return Padding(
                padding: EdgeInsets.only(top: _paddingAnimation.value),
                child: child,
              );
            },
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child){
                return Opacity(
                  opacity: _animation.value,
                  child: child,
                );
              },
              child: AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child){
                  return Transform.scale(scale: _scaleAnimation.value,
                    child: child,);
                },
                child: Image.asset('assets/logo.png',
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.6),
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  AnimatedBuilder(

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          splashButtons['تسجيل الدخول']();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            color: Color(0xff1f80a9),
                          ),
                          child: Text('تسجيل الدخول',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ), animation: _loginAnimation,
                    builder: (context, child){
                      return Transform.translate(offset: Offset(_loginAnimation.value, 0),
                        child: child,
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: _registerAnimation,
                    builder: (context, child){
                      return Transform.translate(offset: Offset(_registerAnimation.value, 0),
                      child: child,);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          splashButtons['التسجيل']();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            color: Color(0xff1f80a9),
                          ),
                          child: Text('التسجيل',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _skipAnimation,
                    builder: (context, child){
                      return Transform.translate(offset: Offset(_skipAnimation.value, 0),
                      child: child,);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          splashButtons['التخطي']();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            color: Color(0xff1f80a9),
                          ),
                          child: Text('التخطي',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
