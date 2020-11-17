import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'cad_detalhes.dart';

import 'default_styles.dart';

class Cadastro extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  var maskFormatter = new MaskTextInputFormatter(
      mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
 final TextEditingController cpfController = new TextEditingController();
  bool continueEnabled = false;

  

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
            key: widget.scaffoldKey,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      child: Text(
                        'Vamos lá! \n Para começar , informe o numero do seu CPF!',
                        textAlign: TextAlign.center,
                        style: defaultTextStyle(25),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      height: 100,
                      child: TextField(
                        inputFormatters: [maskFormatter],
                        controller: cpfController,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.amber,
                        style: defaultTextStyle(20),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2),
                          ),
                          labelStyle: defaultTextStyle(20),
                          contentPadding: EdgeInsets.all(10),
                          labelText: 'CPF',
                        ),
                        onChanged: (cpf) {
                          if (cpf.length == 14) {
                            setState(() {
                              continueEnabled = true;
                            });
                          } else {
                            setState(() {
                              continueEnabled = false;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: RaisedButton(
                        color: Colors.amber[400],
                        elevation: 10,
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
                        onPressed: (continueEnabled)
                            ? () {
                     

                                widget.scaffoldKey.currentState.showBottomSheet(
                                    (context) => CadDetalhes(cpfController.text)); 


                                   

                              }
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




