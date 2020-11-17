import 'package:flutter/material.dart';
import 'package:scidart/numdart.dart';
import 'package:tipcash/widgets/home.dart';
import 'package:tipcash/widgets/title.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'default_styles.dart';
import 'package:http/http.dart' as http;
import 'package:scidart/scidart.dart';

class Login extends StatelessWidget {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController senhaController = new TextEditingController();


  void autenticacao(String email, String senha, BuildContext ctx) async {
    final prefs = await SharedPreferences.getInstance();

    final counter = prefs.getString('email') ?? 0;

    receivevalor(email, senha).then((value) {
      if (value == true) {
        if (counter == 0) {
          prefs.setString('email', email);
          prefs.setString('senha', senha);
        }

        receiveid(email).then((value) {
          Navigator.push(
            ctx,
            MaterialPageRoute(builder: (context) => HomePage(value)),
          );
        });
      }
    });
  }

  Future<bool> receivevalor(String nome, String senha) async {
    final response = await http.get(
        "http://10.0.2.2/exercicios/login.php?nome=" +
            emailController.text +
            "&senha=" +
            senhaController.text);
    String datauser = response.body;

    return intToBool(int.parse(datauser));
  }

  Future<String> receiveid(String nome) async {
    final response =
        await http.get("http://10.0.2.2/exercicios/id.php?nome=" + nome);
    String datauser = response.body;

    return int.parse(datauser).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Scaffold(
              body: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/background1.png'),
                  )))),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 4,
                    child: TitleTipCash(),
                  ),
                  SizedBox(height: 20),
                  Flexible(
                    flex: 3,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      margin: EdgeInsets.only(bottom: 20),
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.amber,
                        style: defaultTextStyle(20),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2),
                          ),
                          labelStyle: defaultTextStyle(20),
                          contentPadding: EdgeInsets.all(10),
                          labelText: 'Nome',
                        ),
                        onChanged: (_) {},
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 3,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      margin: EdgeInsets.only(bottom: 20),
                      child: TextField(
                        controller: senhaController,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.amber,
                        style: defaultTextStyle(20),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2),
                          ),
                          labelStyle: defaultTextStyle(20),
                          contentPadding: EdgeInsets.all(10),
                          labelText: 'Senha',
                        ),
                        onChanged: (_) {},
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(border: Border.all()),
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: RaisedButton(
                          color: Color.fromRGBO(255, 255, 255, 0.5),
                          textColor: Colors.black,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Continuar',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                                Icon(Icons.arrow_forward),
                              ]),
                          onPressed: () {
                            autenticacao(emailController.text,
                                senhaController.text, context);
                          }),
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
