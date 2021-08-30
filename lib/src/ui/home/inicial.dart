import 'package:apptc/core/utils.dart';
import 'package:apptc/src/models/Atividade.dart';
import 'package:apptc/src/public/globals.dart';
import 'package:apptc/src/ui/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Inicial extends StatefulWidget {
  const Inicial({Key key}) : super(key: key);

  @override
  _InicialState createState() => _InicialState();
}

class _InicialState extends State<Inicial> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  var interval = "";
  List list;
  List datacerta = [];
  Dialog ativ;
  var dataAtv = "";

  final _atividade = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  carregaAtividades() async {
    Map obj = Map();
    obj['idusuario'] = idUsuario;
    Map retorno = await promessa(_scaffoldKey, 'GetAtividades', obj);
    if (retorno['situacao'] == 'sucesso' && retorno['obj'].length > 0) {
      list = retorno['obj'];
      listaAtividades = list.map((atv) => Atividade.fromJson(atv)).toList();
      for (int i = 0; i < listaAtividades.length; i++) {
        Atividade ativicty = Atividade();
        ativicty.data_atv = '${listaAtividades[i].data_atv}';
        ativicty.atividade = '${listaAtividades[i].atividade}';
        datacerta.add(ativicty);
        var ano = listaAtividades[i].data_atv.split("-")[0];
        var mes = listaAtividades[i].data_atv.split("-")[1];
        var dia = listaAtividades[i].data_atv.split("-")[2];
        dia = dia.split(" ")[0];
        var hora = listaAtividades[i].data_atv.split(" ")[1];
        datacerta[i].data_atv = dia + "/" + mes + "/" + ano + " " + hora;
      }
    } else {
      listaAtividades = [];
      datacerta = [];
    }

    return listaAtividades;
  }

  void iniciar() async {
    for (int i = 0; i < 24; i++) {
      interval = i.toString();

      Map obj = new Map();
      obj['data_atv'] = interval;
      obj['atividade'] = "escolha a atividade";
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

  void finalizar() {
    int num = listaAtividades.length;
    if (listaAtividades[num - 1].atividade == "escolha a atividade") {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
          duration: Duration(seconds: 2),
          content: new Text('Escolha a todas as atividades.')));
    } else {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
          duration: Duration(seconds: 2), content: new Text('Obrigado!!!')));
      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      });
    }
  }

  atualizaAtvHora() async {
    if (_atividade.text.isNotEmpty) {
      Navigator.of(context).pop();
      Map obj = Map();
      obj['idusuario'] = idUsuario;
      obj['data_atv'] = dataAtv;
      obj['atividade'] = _atividade.text;
      Map retorno = await promessa(_scaffoldKey, 'UpAtividade', obj);
      if (retorno['situacao'] == 'sucesso') {
        setState(() {
          listaAtividades[pos].atividade = _atividade.text;
        });
      }
    } else {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
          duration: Duration(seconds: 1),
          content: new Text('Preencha o campo da atividade')));
    }
  }

  buildCarregaAtividades() {
    return FutureBuilder(
        future: carregaAtividades(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (listaAtividades.length == 0) {
              return Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: SizedBox(
                      width: 150,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        color: Color(0xffb22222),
                        child: Center(
                          child: Text(
                            "INICIAR",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                        onPressed: iniciar,
                      )));
            } else {
              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height / 3,
                    child: ListView.builder(
                      itemCount: listaAtividades.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 1,
                          padding: EdgeInsets.only(right: 10, left: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Text(
                                  datacerta[index].data_atv,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xffb22222),
                                      fontSize: 14,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Text(
                                  listaAtividades[index].atividade,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xffb22222),
                                      fontSize: 14,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: SizedBox(
                                    // ignore: deprecated_member_use
                                    child: RaisedButton(
                                  color: index == 0
                                      ? Color(0xffb22222)
                                      : listaAtividades[index - 1].atividade ==
                                              "escolha a atividade"
                                          ? Colors.grey
                                          : Color(0xffb22222),
                                  child: Center(
                                    child: Text(
                                      "Atv",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'Montserrat'),
                                    ),
                                  ),
                                  onPressed: () {
                                    pos = index;
                                    dataAtv = listaAtividades[index].data_atv;
                                    index == 0
                                        ? showDialog(
                                            context: context,
                                            builder:
                                                (BuildContext context) =>
                                                    Dialog(
                                                      elevation: 10,
                                                      child: Wrap(children: [
                                                        Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 0),
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                1,
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      1,
                                                                  height: 50,
                                                                  color: Color(
                                                                      0xffb22222),
                                                                  child: Stack(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    children: [
                                                                      Positioned(
                                                                        top: 0,
                                                                        left: 0,
                                                                        child:
                                                                            IconButton(
                                                                          icon:
                                                                              Icon(Icons.close),
                                                                          color:
                                                                              Colors.white,
                                                                          iconSize:
                                                                              30.0,
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "Digite a atividade",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                                18,
                                                                            fontFamily:
                                                                                'Montserrat'),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              20),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          border:
                                                                              Border.all(
                                                                    color: Color(
                                                                        0xffb22222),
                                                                  )),
                                                                  child:
                                                                      TextFormField(
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      contentPadding: EdgeInsets.fromLTRB(
                                                                          20.0,
                                                                          15.0,
                                                                          20.0,
                                                                          10.0),
                                                                      focusedBorder:
                                                                          UnderlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                        color: Colors
                                                                            .transparent,
                                                                      )),
                                                                    ),
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xffb22222),
                                                                    ),
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    controller:
                                                                        _atividade,
                                                                    validator:
                                                                        (value) {
                                                                      if (value
                                                                          .isEmpty) {
                                                                        return 'Campo obrigatório';
                                                                      }
                                                                      return null;
                                                                    },
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                SizedBox(
                                                                    width: 150,
                                                                    // ignore: deprecated_member_use
                                                                    child:
                                                                        // ignore: deprecated_member_use
                                                                        RaisedButton(
                                                                      color: Color(
                                                                          0xffb22222),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          "Registrar",
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 15,
                                                                              fontFamily: 'Montserrat'),
                                                                        ),
                                                                      ),
                                                                      onPressed:
                                                                          atualizaAtvHora,
                                                                    )),
                                                                Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        1,
                                                                    height: 30,
                                                                    color: Color(
                                                                        0xffb22222),
                                                                    child: Text(
                                                                        ""))
                                                              ],
                                                            )),
                                                      ]),
                                                    ))
                                        : listaAtividades[index - 1]
                                                    .atividade ==
                                                "escolha a atividade"
                                            ? // ignore: deprecated_member_use
                                            // ignore: deprecated_member_use
                                            _scaffoldKey.currentState
                                                // ignore: deprecated_member_use
                                                .showSnackBar(new SnackBar(
                                                    duration:
                                                        Duration(seconds: 2),
                                                    content: new Text(
                                                        'Escolha a atividade anterior')))
                                            : showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        Dialog(
                                                          elevation: 10,
                                                          child: Wrap(
                                                              children: [
                                                                Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                0),
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        1,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * 1,
                                                                          height:
                                                                              50,
                                                                          color:
                                                                              Color(0xffb22222),
                                                                          child:
                                                                              Stack(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            children: [
                                                                              Positioned(
                                                                                top: 0,
                                                                                left: 0,
                                                                                child: IconButton(
                                                                                  icon: Icon(Icons.close),
                                                                                  color: Colors.white,
                                                                                  iconSize: 30.0,
                                                                                  onPressed: () {
                                                                                    Navigator.of(context).pop();
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                "Digite a atividade",
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Montserrat'),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Container(
                                                                          margin: EdgeInsets.only(
                                                                              left: 20,
                                                                              right: 20),
                                                                          decoration: BoxDecoration(
                                                                              border: Border.all(
                                                                            color:
                                                                                Color(0xffb22222),
                                                                          )),
                                                                          child:
                                                                              TextFormField(
                                                                            decoration:
                                                                                const InputDecoration(
                                                                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                                                                              focusedBorder: UnderlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                color: Colors.transparent,
                                                                              )),
                                                                            ),
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color(0xffb22222),
                                                                            ),
                                                                            keyboardType:
                                                                                TextInputType.text,
                                                                            controller:
                                                                                _atividade,
                                                                            validator:
                                                                                (value) {
                                                                              if (value.isEmpty) {
                                                                                return 'Campo obrigatório';
                                                                              }
                                                                              return null;
                                                                            },
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                150,
                                                                            // ignore: deprecated_member_use
                                                                            child:
                                                                                // ignore: deprecated_member_use
                                                                                RaisedButton(
                                                                              color: Color(0xffb22222),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  "Registrar",
                                                                                  style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Montserrat'),
                                                                                ),
                                                                              ),
                                                                              onPressed: atualizaAtvHora,
                                                                            )),
                                                                        Container(
                                                                            width: MediaQuery.of(context).size.width *
                                                                                1,
                                                                            height:
                                                                                30,
                                                                            color:
                                                                                Color(0xffb22222),
                                                                            child: Text(""))
                                                                      ],
                                                                    )),
                                                              ]),
                                                        ));
                                  },
                                )),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: SizedBox(
                          width: 150,
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                            color: Color(0xffb22222),
                            child: Center(
                              child: Text(
                                "FINALIZAR",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                            onPressed: finalizar,
                          ))),
                ],
              );
            }
          } else if (snapshot.hasError) {
            //print('entrou erro');
            return Text("${snapshot.error}");
          }
          return Container();
        });
  }

  @override
  Widget build(BuildContext context) {
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
                    height: 10,
                  ),
                  buildCarregaAtividades()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
