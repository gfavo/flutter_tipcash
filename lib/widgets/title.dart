import 'package:flutter/material.dart';

class TitleTipCash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
             
              children: <Widget>[
                Flexible(
                  
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Image.asset(
                    'assets/images/splash.png',
                    scale: 2,

                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
                  child: Text(
                    
                    'TIP CASH',

                    style: TextStyle(
                      
                      color: Colors.white,
                      fontSize: 46,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 4
                    ),
                  ),
                )
              ],
            );
  }
}