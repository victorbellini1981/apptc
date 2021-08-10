import 'package:apptc/core/utils.dart';
import 'package:apptc/src/ui/login/cadastro.dart';
import 'package:apptc/src/ui/login/login_recuperasenha.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  // controladores de texto do login e senha
  final _loginController = TextEditingController();
  final _senhaController = TextEditingController();

  var emailuser;
  var senhauser;
  bool lembrar = false;

  @override
  initState() {
    super.initState();
    getUrlServidor();
    lembrarme();
  }

  lembrarme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _loginController.text = prefs.getString('emailuser')!;
      _senhaController.text = prefs.getString('senhauser')!;
      if (_loginController.text != "" && _senhaController.text == "") {
        lembrar = true;
      }
    });
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
        controller: _loginController,
        validator: (value) {
          if (value!.isEmpty) {
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
          prefixIcon: Icon(
            Icons.person,
            color: Color(0xffb22222),
          ),
        ),
        style: TextStyle(
          color: Color(0xffb22222),
        ),
        keyboardType: TextInputType.text,
        controller: _senhaController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Campo obrigatório';
          }
          return null;
        },
      ),
    );

    final chkLembrar = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(width: MediaQuery.of(context).size.width / 4),
        Switch(
          activeColor: Color(0xffb22222),
          value: lembrar,
          onChanged: (value) {
            setState(() {
              lembrar = value;
            });
          },
        ),
        Text(
          "Lembrar",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 15,
            color: Color(0xffb22222),
            fontFamily: 'Montserrat',
          ),
        )
      ],
    );

    final btnEntrar = SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        // ignore: deprecated_member_use
        child: RaisedButton(
          color: Color(0xffb22222),
          child: Center(
            child: Text(
              "LOGIN",
              style: TextStyle(
                  color: Colors.white, fontSize: 20, fontFamily: 'Montserrat'),
            ),
          ),
          onPressed: () {},
        ));

    final lnkEsqueci = GestureDetector(
        child: Text("Esqueci minha senha",
            style: TextStyle(
                color: Color(0xffb22222),
                fontSize: 16,
                fontFamily: 'Montserrat')),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoginRecuperaSenha()));
        });

    final lnkCadastrar = GestureDetector(
        child: Column(
          children: [
            Text("Cadastre-se aqui",
                style: TextStyle(
                    color: Color(0xffb22222),
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold)),
          ],
        ),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cadastro()));
        });

    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xffb22222),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'LOGIN',
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 1,
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 20, right: 20, top: 15),
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
                SizedBox(
                  height: 15,
                ),
                Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: senha),
                chkLembrar,
                btnEntrar,
                SizedBox(
                  height: 5,
                ),
                lnkEsqueci,
                SizedBox(height: 15),
                Column(
                  children: [
                    Text(
                      "AINDA NÃO É CADASTRADO?",
                      style: TextStyle(
                          color: Color(0xffb22222),
                          fontSize: 15,
                          fontFamily: 'Montserrat'),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                lnkCadastrar,
                SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
