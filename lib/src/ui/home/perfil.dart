import 'dart:convert';

import 'package:apptc/src/public/globals.dart';
import 'package:apptc/src/ui/login/login.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Perfil extends StatefulWidget {
  const Perfil({Key key}) : super(key: key);

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController txtnome = new TextEditingController();
  TextEditingController txtemail = new TextEditingController();
  TextEditingController txttelefone = new TextEditingController();
  TextEditingController txtcpf = new TextEditingController();
  TextEditingController txtnumero = new TextEditingController();
  TextEditingController txtcep = new TextEditingController();
  TextEditingController txtlogradouro = new TextEditingController();
  TextEditingController txtcidade = new TextEditingController();
  TextEditingController txtbairro = new TextEditingController();
  TextEditingController txtcomplemento = new TextEditingController();
  TextEditingController txtestado = new TextEditingController();

  @override
  void initState() {
    super.initState();
    txtemail.text = emailpaciente;
    //resultadoMeta();
  }

  consultaCep() async {
    String cep = txtcep.text;

    // ignore: unnecessary_brace_in_string_interps
    String url = 'https://viacep.com.br/ws/${cep}/json/';

    http.Response response;

    response = await http.get(Uri.parse(url));

    Map<String, dynamic> retorno = json.decode(response.body);

    String logradouro = retorno["logradouro"];
    String cidade = retorno["localidade"];
    String bairro = retorno["bairro"];
    String complemento = retorno["complemento"];
    String estado = retorno["uf"];

    setState(() {
      txtlogradouro.text = logradouro;
      txtcidade.text = cidade;
      txtbairro.text = bairro;
      txtcomplemento.text = complemento;
      txtestado.text = estado;
    });
  }

  @override
  Widget build(BuildContext context) {
    final nome = TextFormField(
      decoration: const InputDecoration(
          labelText: 'Nome',
          labelStyle:
              TextStyle(color: Color(0xff472c24), fontWeight: FontWeight.bold),
          hintText: 'Nome Completo',
          hintStyle: TextStyle(
            color: Color(0xff472c24),
          ),
          contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          )),
      keyboardType: TextInputType.text,
      controller: txtnome,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final email = TextFormField(
      decoration: const InputDecoration(
        labelText: 'E-mail',
        labelStyle:
            TextStyle(color: Color(0xff472c24), fontWeight: FontWeight.bold),
        hintText: 'Email atualizado',
        hintStyle: TextStyle(
          color: Color(0xff472c24),
        ),
        contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
      keyboardType: TextInputType.text,
      controller: txtemail,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final cpf = TextFormField(
      decoration: const InputDecoration(
          labelText: 'CPF',
          labelStyle:
              TextStyle(color: Color(0xff472c24), fontWeight: FontWeight.bold),
          hintText: 'Somente números',
          hintStyle: TextStyle(
            color: Color(0xff472c24),
          ),
          contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          )),
      keyboardType: TextInputType.number,
      controller: txtcpf,
      inputFormatters: [TextInputMask(mask: '999.999.999-99', reverse: false)],
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final telefone = TextFormField(
      decoration: const InputDecoration(
          labelText: 'Celular',
          labelStyle:
              TextStyle(color: Color(0xff472c24), fontWeight: FontWeight.bold),
          contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          )),
      keyboardType: TextInputType.number,
      controller: txttelefone,
      inputFormatters: [TextInputMask(mask: '(99) 99999-9999', reverse: false)],
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final logradouro = TextFormField(
      decoration: const InputDecoration(
        labelText: 'Rua ou Avenida',
        labelStyle:
            TextStyle(color: Color(0xff472c24), fontWeight: FontWeight.bold),
        contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff472c24),
          ),
        ),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
      keyboardType: TextInputType.text,
      controller: txtlogradouro,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final numero = TextFormField(
      decoration: const InputDecoration(
        labelText: 'Nº',
        labelStyle:
            TextStyle(color: Color(0xff472c24), fontWeight: FontWeight.bold),
        contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff472c24),
          ),
        ),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
      keyboardType: TextInputType.number,
      controller: txtnumero,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final complemento = TextFormField(
      decoration: const InputDecoration(
        labelText: 'Complemento',
        labelStyle:
            TextStyle(color: Color(0xff472c24), fontWeight: FontWeight.bold),
        contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff472c24),
          ),
        ),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
      keyboardType: TextInputType.text,
      controller: txtcomplemento,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final cep = TextFormField(
      decoration: const InputDecoration(
        labelText: 'CEP',
        hintText: 'Somente números',
        hintStyle: TextStyle(
          color: Color(0xff472c24),
        ),
        labelStyle:
            TextStyle(color: Color(0xff472c24), fontWeight: FontWeight.bold),
        contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
      keyboardType: TextInputType.number,
      controller: txtcep,
      inputFormatters: [TextInputMask(mask: '99999-999', reverse: false)],
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final uf = TextFormField(
      decoration: const InputDecoration(
        labelText: 'UF',
        hintText: 'Ex.: MG',
        hintStyle: TextStyle(
          color: Color(0xff472c24),
        ),
        labelStyle:
            TextStyle(color: Color(0xff472c24), fontWeight: FontWeight.bold),
        contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
      keyboardType: TextInputType.text,
      controller: txtestado,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final bairro = TextFormField(
      decoration: const InputDecoration(
        labelText: 'Bairro',
        labelStyle:
            TextStyle(color: Color(0xff472c24), fontWeight: FontWeight.bold),
        contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
      keyboardType: TextInputType.text,
      controller: txtbairro,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final cidade = TextFormField(
      decoration: const InputDecoration(
        labelText: 'Cidade',
        labelStyle:
            TextStyle(color: Color(0xff472c24), fontWeight: FontWeight.bold),
        contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
      keyboardType: TextInputType.text,
      controller: txtcidade,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final btnSalvar = SizedBox(
        width: 150,
        // ignore: deprecated_member_use
        child: RaisedButton(
          color: Color(0xffb22222),
          child: Center(
            child: Text(
              "SALVAR",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          onPressed: () {},
        ));

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
          child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xffb22222),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'CADASTRO DE DADOS',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 10),
                          child: Column(
                            children: [
                              nome,
                              SizedBox(height: 10),
                              email,
                              SizedBox(height: 10),
                              cpf,
                              SizedBox(height: 10),
                              telefone,
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 10),
                          child: Column(
                            children: [
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 8,
                                    child: cep,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: IconButton(
                                      icon: Icon(Icons.search),
                                      onPressed: consultaCep,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: uf,
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              cidade,
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 9,
                                    child: logradouro,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(" "),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: numero,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 7,
                                    child: complemento,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(" "),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: bairro,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              btnSalvar
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),
        ),
      )),
    );
  }
}
