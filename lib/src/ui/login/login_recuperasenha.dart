import 'package:apptc/core/utils.dart';
import 'package:apptc/src/public/globals.dart';
import 'package:apptc/src/ui/login/login.dart';
import 'package:flutter/material.dart';

class LoginRecuperaSenha extends StatefulWidget {
  const LoginRecuperaSenha({Key? key}) : super(key: key);

  @override
  _LoginRecuperaSenhaState createState() => _LoginRecuperaSenhaState();
}

class _LoginRecuperaSenhaState extends State<LoginRecuperaSenha> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formkey = new GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _codigoController = TextEditingController();
  final _confirmarController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _obscuresenha = true;
  bool _obscureconfirma = true;
  @override
  void initState() {
    super.initState();
  }

  bool obscuretext = true;

  @override
  Widget build(BuildContext context) {
    final email = Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: Color(0xffb22222),
      )),
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: 'E-mail',
          hintStyle: TextStyle(
              color: Color(0xffb22222),
              fontSize: 13,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.transparent,
          )),
          prefixIcon: Icon(
            Icons.person,
            color: Color(0xffb22222),
          ),
        ),
        style: TextStyle(
          color: Color(0xffb22222),
        ),
        keyboardType: TextInputType.text,
        controller: _emailController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Campo obrigatório';
          }
          return null;
        },
      ),
    );
// função que altera a senha do usuário
    recuperarSenha() async {
      var auxsenha = _senhaController.text;
      var auxconfirma = _confirmarController.text;
      var novasenha = textToMd5("*${auxsenha.trim()}${configApp.nomeApp}");
      var confirmasenha =
          textToMd5("*${auxconfirma.trim()}${configApp.nomeApp}");
      if (_codigoController.text.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                content: Text(
              'Digite o código que foi enviado para seu e-mail!',
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ));
          },
        );
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
      }
      if (novasenha == confirmasenha && _senhaController.text.isNotEmpty) {
        Map obj = Map();
        obj['senha'] = novasenha;

        Map<String, dynamic>? retorno = await promessaRecSenha(
            _scaffoldKey, 'SetSenha', obj, _codigoController.text);
        if (retorno!['situacao'] == 'sucesso') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  content: Text(
                'Não foi possível atualizar, tente mais tarde!',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ));
            },
          );
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop();
          });
        }
      } else {
        // ignore: deprecated_member_use
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                content: Text(
              'Confirmar senha tem que ser igual à nova senha',
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ));
          },
        );
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
      }
    }

// função para criar e enviar um código pro e-mail e digitar a nova senha
    recuperar() async {
      if (_emailController.text.isNotEmpty) {
        Map obj = Map();
        obj['email'] = _emailController.text;
        Map<String, dynamic>? retorno =
            await promessa(_scaffoldKey, "GetSenha", obj);
        if (retorno!['situacao'] == "sucesso") {
          showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(
                    builder: (dialogcontext, setState) => Dialog(
                          elevation: 10,
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height / 2,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      color: Color(0xffe6a2a1),
                                      child: Text(
                                        'Verifique seu e-mail e preencha os dados abaixo:',
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 10.0, right: 10),
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                labelText: 'Código',
                                                labelStyle: TextStyle(
                                                    color: Colors.black),
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        0.0, 10.0, 20.0, 10.0),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.grey)),
                                              ),
                                              keyboardType: TextInputType.text,
                                              controller: _codigoController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Campo obrigatório';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 10.0, right: 10),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'Nova Senha',
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(0.0,
                                                          10.0, 20.0, 10.0),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey)),
                                                  suffixIcon: IconButton(
                                                    icon: _obscuresenha == true
                                                        ? Icon(
                                                            Icons.visibility,
                                                            color: Colors.grey,
                                                          )
                                                        : Icon(
                                                            Icons
                                                                .visibility_off,
                                                            color: Colors.grey,
                                                          ),
                                                    onPressed: () {
                                                      setState(() {
                                                        if (_obscuresenha) {
                                                          _obscuresenha = false;
                                                        } else {
                                                          _obscuresenha = true;
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ),
                                                obscureText: _obscuresenha,
                                                keyboardType:
                                                    TextInputType.text,
                                                controller: _senhaController,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Campo obrigatório';
                                                  }
                                                  return null;
                                                },
                                              )),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 10.0, right: 10),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'Confirmar senha',
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(0.0,
                                                          10.0, 20.0, 10.0),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey)),
                                                  suffixIcon: IconButton(
                                                    icon: _obscureconfirma ==
                                                            true
                                                        ? Icon(
                                                            Icons.visibility,
                                                            color: Colors.grey,
                                                          )
                                                        : Icon(
                                                            Icons
                                                                .visibility_off,
                                                            color: Colors.grey,
                                                          ),
                                                    onPressed: () {
                                                      setState(() {
                                                        if (_obscureconfirma) {
                                                          _obscureconfirma =
                                                              false;
                                                        } else {
                                                          _obscureconfirma =
                                                              true;
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ),
                                                obscureText: _obscureconfirma,
                                                keyboardType:
                                                    TextInputType.text,
                                                controller:
                                                    _confirmarController,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Campo obrigatório';
                                                  }
                                                  return null;
                                                },
                                              )),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            height: 40,
                                            // ignore: deprecated_member_use
                                            child: RaisedButton(
                                              child: Text('Confirmar',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 20.0)),
                                              onPressed: recuperarSenha,
                                              color: Color(0xffe6a2a1),
                                              textColor: Colors.white,
                                              shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        30.0),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ));
              });
          /* Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login())); */
        } else if (retorno['msg'] == "E-mail não cadastrado.") {
          Map obj = Map();
          obj['email'] = _emailController.text;
          Map<String, dynamic>? retorno =
              await promessa(_scaffoldKey, "GetPessoaEmail", obj);
          if (retorno!['situacao'] == 'sucesso' &&
              retorno['obj']['idpessoa'] != 0) {
            // ignore: deprecated_member_use
            _scaffoldKey.currentState!.showSnackBar(new SnackBar(
                duration: Duration(seconds: 2),
                content: new Text(
                  'Seu cadastro foi realizado pelas redes socias, Entre pelo Google ou pelo Facebook',
                  maxLines: 4,
                )));
          } else {
            // ignore: deprecated_member_use
            _scaffoldKey.currentState!.showSnackBar(new SnackBar(
                duration: Duration(seconds: 1),
                content: new Text('Usuário não cadastrado')));
          }
        }
      } else {
        // ignore: deprecated_member_use
        _scaffoldKey.currentState!.showSnackBar(new SnackBar(
            duration: Duration(seconds: 1),
            content: new Text('Digite seu e-mail')));
      }
    }

    final btnrecuperarSenha = SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,

      // ignore: deprecated_member_use
      child: RaisedButton(
        child: Text('RECUPERAR SENHA',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w300)),
        onPressed: recuperar,
        color: Color(0xffb22222),
        textColor: Colors.white,
      ),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xffb22222),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'RECUPERAR SENHA',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        body: Form(
          key: _formkey,
          child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                      SizedBox(height: 60),
                      Center(
                        child: Column(
                          children: <Widget>[
                            /* Container(
                              width: 70,
                              height: 70,
                              child: Image.asset('assets/images/CADEADO.png'),
                            ), */
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'ESQUECEU SUA SENHA?',
                              style: TextStyle(
                                fontSize: 25,
                                color: Color(0xffb22222),
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Digite seu e-mail que enviaremos um código para redefinição de sua senha",
                                  style: TextStyle(
                                      color: Color(0xffb22222), fontSize: 15),
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 30, right: 30),
                                child: email),
                            SizedBox(
                              height: 10,
                            ),
                            btnrecuperarSenha,
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width * 1,
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                },
                                child: Text(
                                  'VOLTAR',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffb22222),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
