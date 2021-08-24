import 'package:apptc/core/utils.dart';
import 'package:apptc/src/public/globals.dart';
import 'package:apptc/src/ui/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key key}) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool cadastrando = false;
  bool _obscuresenha = true;
  @override
  void initState() {
    super.initState();
    getUrlServidor();
  }

// tela de Cadastro simples, com campos e-mail, senha e função pra cadastro de usuario

  //controladores de texto da senha e do login
  TextEditingController txtsenha = new TextEditingController();
  TextEditingController txtlogin = new TextEditingController();

  void cadastrar() async {
    setState(() {
      cadastrando = true;
    });
    if (txtlogin.text.contains('@') && txtlogin.text.contains('.com')) {
      if (txtsenha.text.length <= 8) {
        Map obj = Map();
        obj["email"] = txtlogin.text.trim();
        obj["senha"] =
            textToMd5("*${txtsenha.text.trim()}${configApp.nomeApp}");
        Map<String, dynamic> retorno =
            await promessa(_scaffoldKey, "GetLoginP", obj);
        ////print(json.encode(retorno["arrayObj"]));
        if (retorno["situacao"] == "sucesso" &&
            retorno['obj']['idpaciente'] != 0) {
          // ignore: deprecated_member_use
          _scaffoldKey.currentState.showSnackBar(new SnackBar(
              duration: Duration(seconds: 1),
              content: new Text('Usuario já cadastrado!')));
          setState(() {
            cadastrando = false;
          });
        } else {
          Map<String, dynamic> retorno1 =
              await promessa(_scaffoldKey, "PostUsuarioP", obj);
          if (retorno1["situacao"] == "sucesso" &&
              retorno1['obj']['idpaciente'] != 0) {
            // ignore: deprecated_member_use
            _scaffoldKey.currentState.showSnackBar(new SnackBar(
                duration: Duration(seconds: 1),
                content: new Text('Cadastro realizado com sucesso!')));
            Future.delayed(Duration(seconds: 1), () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            });
          }
        }
      } else {
        // ignore: deprecated_member_use
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Senha deve conter no máximo 8 dígitos.'),
          duration: Duration(seconds: 5),
        ));
        setState(() {
          cadastrando = false;
        });
      }
    } else {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('E-mail inválido.'),
        duration: Duration(seconds: 2),
      ));
      setState(() {
        cadastrando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final login = Container(
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
        controller: txtlogin,
        validator: (value) {
          if (value.isEmpty) {
            return 'Campo obrigatório';
          }
          return null;
        },
      ),
    );

    final senha = Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: Color(0xffb22222),
      )),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Senha',
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
          suffixIcon: IconButton(
            icon: _obscuresenha == true
                ? Icon(
                    Icons.visibility,
                    color: Color(0xffb22222),
                  )
                : Icon(
                    Icons.visibility_off,
                    color: Color(0xffb22222),
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
          prefixIcon: Icon(
            Icons.lock,
            color: Color(0xffb22222),
          ),
        ),
        style: TextStyle(
          color: Color(0xffb22222),
        ),
        keyboardType: TextInputType.text,
        obscureText: _obscuresenha,
        controller: txtsenha,
        validator: (value) {
          if (value.isEmpty) {
            return 'Campo obrigatório';
          }
          return null;
        },
      ),
    );

    final btnCadastrar = SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        // ignore: deprecated_member_use
        child: RaisedButton(
          color: Color(0xffb22222),
          child: Center(
            child: Text(
              cadastrando == false ? "CADASTRAR" : "CADASTRANDO",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w300),
            ),
          ),
          onPressed: cadastrando == false ? cadastrar : null,
        ));

    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xffb22222),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'CADASTRO',
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
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
                SizedBox(
                  height: 30,
                ),
                Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: login),
                SizedBox(height: 30),
                Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: senha),
                SizedBox(height: 30),
                btnCadastrar,
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
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
        ),
      ),
    ));
  }
}
