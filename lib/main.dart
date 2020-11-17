import 'package:flutter/material.dart';
import 'package:tipcash/widgets/intro_buttons.dart';
import 'package:tipcash/widgets/login.dart';
import 'package:tipcash/widgets/title.dart';

import 'widgets/cadastro.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  void _cadastroHandler(BuildContext ctx) {
    Navigator.of(ctx).push(_createRoute(Cadastro()));
  }

  void _loginHandler(BuildContext ctx) {
    Navigator.of(ctx).push(_createRoute(Login()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/background1.png'),
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 120,
                ),
                Flexible(
                  child: TitleTipCash(),
                ),
                Flexible(
                  child: IntroButtons(_cadastroHandler, _loginHandler),
                )
              ],
            )),
      ),
    );
  }
}

Route _createRoute(Widget destination) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => destination,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}


