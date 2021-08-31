import 'package:apptc/core/utils.dart';
import 'package:apptc/src/public/globals.dart';
import 'package:apptc/src/ui/home/inicial.dart';
import 'package:easy_mask/easy_mask.dart';
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
  bool entre;
  @override
  void initState() {
    super.initState();
    getUrlServidor();
  }

// tela de Cadastro simples, com campos e-mail, senha e função pra cadastro de usuario

  //controladores de texto da senha e do login
  TextEditingController txtsenha = new TextEditingController();
  TextEditingController txtlogin = new TextEditingController();
  TextEditingController txtnome = new TextEditingController();
  TextEditingController txttelefone = new TextEditingController();
  TextEditingController txtcpf = new TextEditingController();
  TextEditingController txtidade = new TextEditingController();
  TextEditingController txtaltura = new TextEditingController();
  TextEditingController txtpeso = new TextEditingController();

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
            retorno['obj']['idusuario'] != 0) {
          // ignore: deprecated_member_use
          _scaffoldKey.currentState.showSnackBar(new SnackBar(
              duration: Duration(seconds: 1),
              content: new Text('Usuario já cadastrado!')));
          setState(() {
            cadastrando = false;
          });
        } else if (txtnome.text.isEmpty) {
          // ignore: deprecated_member_use
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Digite o nome completo!'),
            duration: Duration(seconds: 3),
          ));
          setState(() {
            cadastrando = false;
          });
        } else if (txtcpf.text.length < 14) {
          // ignore: deprecated_member_use
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Cpf inválido'),
            duration: Duration(seconds: 3),
          ));
          setState(() {
            cadastrando = false;
          });
        } else if (txtnome.text.isNotEmpty) {
          var cpf = txtcpf.text.replaceAll('.', '');
          cpf = cpf.replaceAll('-', '');
          var soma = 0;
          var soma2 = 0;
          var resto;
          var resto2;
          for (int i = 1; i <= 9; i++) {
            soma = soma + int.parse(cpf[i - 1]) * (11 - i);
          }
          resto = (soma * 10) % 11;
          if (resto == 10 || resto == 11) {
            resto = 0;
          }
          for (int i = 1; i <= 10; i++) {
            soma2 = soma2 + int.parse(cpf[i - 1]) * (12 - i);
          }
          resto2 = (soma2 * 10) % 11;
          if (resto2 == 10 || resto2 == 11) {
            resto2 = 0;
          }
          entre = true;
          if (cpf == '00000000000' ||
              cpf == '11111111111' ||
              cpf == '22222222222' ||
              cpf == '33333333333' ||
              cpf == '44444444444' ||
              cpf == '55555555555' ||
              cpf == '66666666666' ||
              cpf == '77777777777' ||
              cpf == '88888888888' ||
              cpf == '99999999999' ||
              resto != int.parse(cpf[9]) ||
              resto2 != int.parse(cpf[10])) {
            entre = false;
            // ignore: deprecated_member_use
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('CPF inválido!'),
              duration: Duration(seconds: 3),
            ));
            setState(() {
              cadastrando = false;
            });
          } else if (txttelefone.text.length < 15) {
            entre = false;
            // ignore: deprecated_member_use
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('Digite seu celular!'),
              duration: Duration(seconds: 3),
            ));
            setState(() {
              cadastrando = false;
            });
          } else if (txtidade.text.isEmpty) {
            // ignore: deprecated_member_use
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('Digite sua idade!'),
              duration: Duration(seconds: 3),
            ));
            setState(() {
              cadastrando = false;
            });
          } else if (txtpeso.text.isEmpty) {
            // ignore: deprecated_member_use
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('Digite seu peso!'),
              duration: Duration(seconds: 3),
            ));
            setState(() {
              cadastrando = false;
            });
          } else if (txtaltura.text.isEmpty) {
            // ignore: deprecated_member_use
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('Digite sua altura!'),
              duration: Duration(seconds: 3),
            ));
            setState(() {
              cadastrando = false;
            });
          } else {
            Map obj = Map();
            obj["email"] = txtlogin.text.trim();
            obj["senha"] =
                textToMd5("*${txtsenha.text.trim()}${configApp.nomeApp}");
            obj["nome"] = txtnome.text.toUpperCase();
            obj["cpf"] = txtcpf.text;
            obj["telefone"] = txttelefone.text;
            obj["idade"] = txtidade.text;
            obj["altura"] = txtaltura.text;
            obj["peso"] = txtpeso.text;
            Map<String, dynamic> retorno1 =
                await promessa(_scaffoldKey, "PostUsuarioP", obj);
            if (retorno1["situacao"] == "sucesso" &&
                retorno1['obj']['idusuario'] != 0) {
              idUsuario = retorno1['obj']['idusuario'];
              nomeusuario = txtnome.text;
              // ignore: deprecated_member_use
              _scaffoldKey.currentState.showSnackBar(new SnackBar(
                  duration: Duration(seconds: 1),
                  content: new Text('Cadastro realizado com sucesso!')));
              Future.delayed(Duration(seconds: 1), () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Inicial()));
              });
            } else {
              setState(() {
                cadastrando = false;
              });
              // ignore: deprecated_member_use
              _scaffoldKey.currentState.showSnackBar(new SnackBar(
                  duration: Duration(seconds: 1),
                  content: new Text('Erro ao cadastrar usuário!')));
            }
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
    final login = TextFormField(
      decoration: const InputDecoration(
        labelText: 'E-mail',
        labelStyle: TextStyle(
            color: Color(0xffb22222),
            fontSize: 14,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Color(0xffb22222),
        )),
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
    );

    final senha = TextFormField(
      decoration: InputDecoration(
        labelText: 'Senha',
        labelStyle: TextStyle(
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
    );

    final nome = TextFormField(
      decoration: const InputDecoration(
        labelText: 'Nome Completo',
        labelStyle: TextStyle(
            color: Color(0xffb22222),
            fontSize: 13,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.transparent,
        )),
      ),
      style: TextStyle(
        color: Color(0xffb22222),
      ),
      keyboardType: TextInputType.text,
      controller: txtnome,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final telefone = TextFormField(
      decoration: InputDecoration(
        labelText: 'Celular',
        labelStyle: TextStyle(
            color: Color(0xffb22222),
            fontSize: 13,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.transparent,
        )),
      ),
      style: TextStyle(
        color: Color(0xffb22222),
      ),
      keyboardType: TextInputType.text,
      controller: txttelefone,
      inputFormatters: [TextInputMask(mask: '(99) 99999-9999', reverse: false)],
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final cpf = TextFormField(
      decoration: const InputDecoration(
        labelText: 'Cpf',
        labelStyle: TextStyle(
            color: Color(0xffb22222),
            fontSize: 13,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.transparent,
        )),
      ),
      style: TextStyle(
        color: Color(0xffb22222),
      ),
      keyboardType: TextInputType.text,
      controller: txtcpf,
      inputFormatters: [TextInputMask(mask: '999.999.999-99', reverse: false)],
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final idade = TextFormField(
      decoration: InputDecoration(
        labelText: 'Idade',
        labelStyle: TextStyle(
            color: Color(0xffb22222),
            fontSize: 14,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Color(0xffb22222),
        )),
      ),
      style: TextStyle(
        color: Color(0xffb22222),
      ),
      keyboardType: TextInputType.text,
      controller: txtidade,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final peso = TextFormField(
      decoration: const InputDecoration(
        labelText: 'Peso',
        labelStyle: TextStyle(
            color: Color(0xffb22222),
            fontSize: 14,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Color(0xffb22222),
        )),
      ),
      style: TextStyle(
        color: Color(0xffb22222),
      ),
      keyboardType: TextInputType.text,
      controller: txtpeso,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final altura = TextFormField(
      decoration: InputDecoration(
        labelText: 'Altura',
        labelStyle: TextStyle(
            color: Color(0xffb22222),
            fontSize: 14,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Color(0xffb22222),
        )),
      ),
      style: TextStyle(
        color: Color(0xffb22222),
      ),
      keyboardType: TextInputType.text,
      controller: txtaltura,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
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
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
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
                  height: 10,
                ),
                login,
                SizedBox(height: 5),
                senha,
                SizedBox(height: 5),
                nome,
                SizedBox(height: 5),
                cpf,
                SizedBox(height: 5),
                telefone,
                SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: idade,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(" "),
                    ),
                    Expanded(
                      flex: 3,
                      child: peso,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(" "),
                    ),
                    Expanded(
                      flex: 3,
                      child: altura,
                    )
                  ],
                ),
                SizedBox(height: 5),
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
