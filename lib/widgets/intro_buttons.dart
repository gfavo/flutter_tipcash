import 'package:flutter/material.dart';

class IntroButtons extends StatelessWidget {
  final Function cadastrarHandler;
  final Function loginHandler;

  IntroButtons(this.cadastrarHandler, this.loginHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 350,
            height: 60,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.amber)),
            child: RaisedButton(
              color: Colors.amber[300],
              child: Text(
                'Quero me cadastrar!',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
              onPressed: () {
                cadastrarHandler(context);
              },
            ),
          ),
          Container(
            width: 350,
            height: 60,
            child: RaisedButton(
              color: Colors.transparent,
              textColor: Colors.white,
              child: Text(
                'Ja tenho uma conta',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
              onPressed: () {
                loginHandler(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
