import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;


class Qr extends StatefulWidget {
  @override
  _QrState createState() => _QrState();
}

class _QrState extends State<Qr> {
  Future<String> resultF;
  String result;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                child: Text('Abrir'),
                onPressed: ()  {
              
                 resultF =  scanner.scan().then((String result_) {
                   setState(() {
                     result = result_;
                   });
                 });
    
                                     
                }),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              child: Text('Resultado: $result',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    ));
  }
}