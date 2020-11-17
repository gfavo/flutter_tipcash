import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/gestures.dart';
import 'package:tipcash/widgets/default_styles.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tipcash/widgets/qrscan.dart';

class HomePage extends StatefulWidget {
  String idusuario;

  HomePage(this.idusuario);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController valorController = new TextEditingController();

  bool _obscureText = true;
  String _valor = "";
  Icon reveal = new Icon(Icons.remove_red_eye);

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;

      if (_obscureText) {
        _valor = 'R\$' + valor_conta.toString();
        reveal = new Icon(Icons.remove_red_eye, color: Colors.white);
      } else {
        reveal = new Icon(Icons.remove_red_eye, color: Colors.black);
        _valor = "***";
      }
    });
  }

  void apagalogin() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove('email');
    prefs.remove('senha');
  }

  int valor_conta;

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
    ),
    Text(
      'Index 1: Business',
    ),
    Text(
      'Index 2: School',
    ),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index, ctx) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        MaterialPageRoute(builder: (context) => Qr());
      }
    });
  }

  Future<List> senddata() async {
    final response = await http.post(
        "http://10.0.2.2/exercicios/mudarsaldo.php",
        body: {"valor": valorController.text, "idusuario": widget.idusuario});
    String datauser = response.body;
  }

  Future<String> receivevalor() async {
    final response = await http.get(
        "http://10.0.2.2/exercicios/receber.php?idusuario=" + widget.idusuario);
    String datauser = response.body;
    setState(() {
      valor_conta = int.parse(datauser);
      if (_obscureText) {
        _valor = 'R\$' + valor_conta.toString();
        reveal = new Icon(Icons.remove_red_eye, color: Colors.white);
      } else {
        reveal = new Icon(Icons.remove_red_eye, color: Colors.black);
        _valor = "***";
      }
    });
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(),
            child: Column(children: <Widget>[
              Text(
                'Valor a ser adicionado: ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                margin: EdgeInsets.only(bottom: 20),
                child: TextField(
                  controller: valorController,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.amber,
                  style: TextStyle(color: Colors.black, fontSize: 25),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 2),
                    ),
                    labelStyle: defaultTextStyle(20),
                    contentPadding: EdgeInsets.all(10),
                    labelText: 'Email',
                  ),
                  onChanged: (_) {},
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                width: 350,
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.blueGrey)),
                child: RaisedButton(
                  color: Colors.white10,
                  child: Text(
                    'Adicionar',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 20),
                  ),
                  onPressed: () {
                    senddata();
                    receivevalor();
                  },
                ),
              ),
            ]),
          );
        });
  }

  bool valor = false;

  @override
  Widget build(BuildContext context) {
    receivevalor().then((value) {
      if (_valor == "") {
        _valor = 'R\$' + valor_conta.toString();
      }
    });

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 5),
                Text(
                  'Saldo do Tip Cash',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'Roboto',
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 20),
                      Center(
                          child: Text(_valor,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontFamily: 'Roboto',
                              ))),
                      SizedBox(width: 15),
                      new FlatButton(
                        child: reveal,
                        onPressed: () => _toggle(),
                      ),
                    ]),
                Container(
                  width: 350,
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.amber)),
                  child: RaisedButton(
                    color: Colors.amber[300],
                    child: Text(
                      'Adicionar',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    ),
                    onPressed: () {
                      _settingModalBottomSheet(context);
                    },
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(color: Color.fromRGBO(36, 57, 127, 1)),
            width: double.infinity,
            height: 250,
          ),
          Container(
            height: 50,
            color: Colors.grey[300],
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Usar saldo para pagar',
                    style: TextStyle(fontSize: 25),
                  ),
                  Checkbox(
                    value: valor,
                    onChanged: (bool resp) {
                      setState(() {
                        valor = resp;
                      });
                    },
                  )
                ]),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.credit_card,
              color: Color.fromRGBO(36, 57, 127, 1),
              size: 80,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 60,
            color: Colors.grey[300],
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add_circle,
                    color: Color.fromRGBO(36, 57, 127, 1),
                    size: 40,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Adicionar cartão',
                    style: TextStyle(
                        fontSize: 25, color: Color.fromRGBO(36, 57, 127, 1)),
                  ),
                ]),
          ),
          FlatButton(
            child: Text("Qr"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Qr()),
              );
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline,
              size: 50,
            ),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (_) => _onItemTapped(_selectedIndex, context),
      ),
    );
  }
}
