import 'package:apptc/core/utils.dart';
import 'package:apptc/src/models/Atividade.dart';
import 'package:apptc/src/public/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Inicial extends StatefulWidget {
  const Inicial({Key key}) : super(key: key);

  @override
  _InicialState createState() => _InicialState();
}

class _InicialState extends State<Inicial> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool finalizado = false;
  var interval = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void iniciar() async {
      for (int i = 0; i < 24; i++) {
        interval = i.toString();

        Map obj = new Map();
        obj['data_atv'] = interval;
        obj['atividade'] = "";
        obj['idusuario'] = idUsuario;

        Map retorno = await promessa(_scaffoldKey, "PostAtividade", obj);

        if (retorno["situacao"] == "sucesso" &&
            retorno['obj']['idatividade'] != 0 &&
            i == 23) {
          // ignore: deprecated_member_use
          _scaffoldKey.currentState.showSnackBar(new SnackBar(
              duration: Duration(seconds: 2),
              content: new Text('Atividades cadastradas com sucesso')));
        }
      }
    }

    void finalizar() {}

    final btnEntrar = SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        // ignore: deprecated_member_use
        child: RaisedButton(
          color: Color(0xffb22222),
          child: Center(
            child: Text(
              finalizado == false ? "INICIAR" : "FINALIZAR",
              style: TextStyle(
                  color: Colors.white, fontSize: 20, fontFamily: 'Montserrat'),
            ),
          ),
          onPressed: finalizado == true ? finalizar : iniciar,
        ));

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Color(0xffb22222),
            automaticallyImplyLeading: true,
            centerTitle: true,
            title: Text(
              'ATIVIDADES',
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          body: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 1,
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(left: 20, right: 20, top: 15),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 210,
                        height: 110,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/images/eletrocardiograma.png"), // <-- BACKGROUND IMAGE
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Image.asset(
                          "assets/images/coracao.gif",
                          height: 80.0,
                          width: 80.0,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Text("Bem Vindo(a)!",
                        style: TextStyle(
                            color: Color(0xffb22222),
                            fontSize: 20,
                            fontFamily: 'Montserrat')),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      nomeusuario,
                      style: TextStyle(
                          color: Color(0xffb22222),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  btnEntrar
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
