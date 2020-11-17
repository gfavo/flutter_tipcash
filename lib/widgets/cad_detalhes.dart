import 'package:flutter/material.dart';

import 'default_styles.dart';
import 'package:http/http.dart' as http;

class CadDetalhes extends StatefulWidget {
  final String cpf;

  CadDetalhes(this.cpf);

  @override
  _CadDetalhesState createState() => _CadDetalhesState();
}

class _CadDetalhesState extends State<CadDetalhes> {
  final TextEditingController nomeController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController senhaController = new TextEditingController();
  final TextEditingController cel1Controller = new TextEditingController();
  final TextEditingController cel2Controller = new TextEditingController();

  EdgeInsets bordaForms =
      EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 20);

  Future<void> _showMyDialog(sucess) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alerta'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(sucess),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
             
                  int count = 0;
                  Navigator.popUntil(context, (route) {
                    return count++ == 3;
                  });
                
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> senddata(nome, senha, email, cel1, cel2, cpf) async {
    final response =
        await http.post("http://10.0.2.2/exercicios/cadastro.php", body: {
      "nome": nome,
      "email": email,
      "senha": senha,
      "cel1": cel1,
      "cel2": cel2,
      "cpf": cpf,
    });
    String datauser = response.body;
    return datauser;
  }

  InputDecoration decoracaoInput(String texto) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1.6,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.amber, width: 1.6),
      ),
      labelStyle: defaultTextStyleColor(15, Colors.grey),
      contentPadding: EdgeInsets.all(10),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      labelText: texto,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 1.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 25),
            Flexible(
              child: Container(
                margin: bordaForms,
                child: TextField(
                  // inputFormatters: [maskFormatter],
                  controller: nomeController,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.amber,
                  style: defaultTextStyleColor(20, Colors.black),
                  decoration: decoracaoInput("Nome"),
                  onChanged: (_) {},
                ),
              ),
            ),
            Flexible(
              child: Row(
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Container(
                      margin: bordaForms,
                      child: TextField(
                        // inputFormatters: [maskFormatter],
                        controller: cel1Controller,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.amber,
                        style: defaultTextStyleColor(20, Colors.black),
                        decoration: decoracaoInput('Cel1'),
                        onChanged: (_) {},
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      margin: bordaForms,
                      child: TextField(
                        // inputFormatters: [maskFormatter],
                        controller: cel2Controller,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.amber,
                        style: defaultTextStyleColor(20, Colors.black),
                        decoration: decoracaoInput('Cel2'),
                        onChanged: (_) {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Container(
                margin: bordaForms,
                child: TextField(
                  // inputFormatters: [maskFormatter],
                  controller: emailController,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.amber,
                  style: defaultTextStyleColor(20, Colors.black),
                  decoration: decoracaoInput('Email'),
                  onChanged: (_) {},
                ),
              ),
            ),
            Flexible(
              child: Container(
                margin: bordaForms,
                child: TextField(
                  // inputFormatters: [maskFormatter],
                  controller: senhaController,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.amber,
                  style: defaultTextStyleColor(20, Colors.black),
                  decoration: decoracaoInput('Senha'),
                  onChanged: (_) {},
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              height: 60,
              width: MediaQuery.of(context).size.width * 0.9,
              child: RaisedButton(
                  color: Colors.white,
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
                    senddata(
                            nomeController.text,
                            emailController.text,
                            senhaController.text,
                            cel1Controller.text,
                            cel2Controller.text,
                            widget.cpf)
                        .then((value) {
                      _showMyDialog(value);
                    });
                  }),
            ),
          ],
        ));
  }
}
