import 'dart:async';

import 'package:apptc/src/public/globals.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/*Future<String> getUrlServidor() async {
  final response = await http.get(
      "https://sistemaagely.com.br/ajax?tela=GetVersaoApp&app=${configApp.nomeApp}&teste=${configApp.teste}&linkCompleto=true");

  if (response.statusCode == 200) {
    configApp.urlServidor = json.decode(response.body);
    return configApp.urlServidor;
  } else {
    throw Exception('Failed to load post');
  }
}*/

// ignore: missing_return
Future<String> getUrlServidor() async {
  if (configApp.testeServidor == false) {
    final response = await http.get(Uri.parse(
        "https://sistemaagely.com.br/ajax?tela=GetVersaoApp&app=${configApp.nomeApp}&teste=${configApp.teste}&linkCompleto=true"));

    //print("response.body = " +

    if (response.statusCode == 200) {
      configApp.urlServidor = json.decode(response.body) + "/";
      return configApp.urlServidor;
    } else {
      throw Exception('Failed to load post');
    }
  } else {
    //configApp.urlServidor = "http://192.168.106.125:8080/Projetotc/";
    configApp.urlServidor = "http://192.168.0.106:8080/Projetotc/";
    //configApp.urlServidor = "http://192.168.56.1:8080/Projetotc/";
    /* configApp.urlServidor =
        "https://sistemaagely.com.br:8245/ChaDeLingerie24112020/"; */
    return configApp.urlServidor;
  }
}

/*Future<Map<String, dynamic>> promessa(
    GlobalKey<ScaffoldState> scaffoldKey, String servico, Object obj) async {
  //String objjson = json.encode(obj);
  /*String url =
      "${configApp.urlServidor}/${configApp.servlet}?tela=${servico}&obj=${objjson}";*/
  //String url = "${configApp.urlServidor}/${configApp.servlet}?tela=${servico}";
  String url =
      // ignore: unnecessary_brace_in_string_interps
      // 'https://sistemaagely.com.br:8245/ChaDeLingerie27082020/chadelingerie?metodo=${servico}';
      // ignore: unnecessary_brace_in_string_interps
      "${configApp.urlServidor}${configApp.servlet}?metodo=${servico}";

  final response = await http.get(url);

  if (response.statusCode == 200) {
    try {
      return json.decode(response.body);
    } catch (e) {
      //throw Exception('Formato inválido de retorno');
      scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text(
              "Falha ao ler dados do servidor! Verifique sua conexão com a internet.")));

      return null;
    }
  } else {
    //throw Exception('Failed to load post');
    scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(
            "Falha de comunicação! Verifique sua conexão com a internet.")));
    return null;
  }
}*/

Future<Map<String, dynamic>> promessaRecSenha(
    GlobalKey<ScaffoldState> scaffoldKey,
    String servico,
    Object obj,
    String codigo) async {
  String objjson = json.encode(obj);

  String url =
      // ignore: unnecessary_brace_in_string_interps
      "${configApp.urlServidor}${configApp.servlet}?metodo=${servico}&obj=${objjson}&codigo=${codigo}";
  //String url = "${configApp.urlServidor}/${configApp.servlet}?tela=${servico}";
  //print(url);

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    try {
      return json.decode(response.body);
    } catch (e) {
      //throw Exception('Formato inválido de retorno');
      // ignore: deprecated_member_use
      scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text(
              "Falha ao ler dados do servidor! Verifique sua conexão com a internet.")));

      return null;
    }
  } else {
    //throw Exception('Failed to load post');
    // ignore: deprecated_member_use
    scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(
            "Falha de comunicação! Verifique sua conexão com a internet.")));
    return null;
  }
}

Future<Map<String, dynamic>> promessa(
    GlobalKey<ScaffoldState> scaffoldKey, String servico, Object obj) async {
  String objjson = json.encode(obj);

  String url =
      // ignore: unnecessary_brace_in_string_interps
      "${configApp.urlServidor}${configApp.servlet}?metodo=${servico}&obj=${objjson}";
  //String url = "${configApp.urlServidor}/${configApp.servlet}?tela=${servico}";
  print(url);

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    try {
      return json.decode(response.body);
    } catch (e) {
      //throw Exception('Formato inválido de retorno');

      // ignore: deprecated_member_use
      scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text(
              "Falha ao ler dados do servidor! Verifique sua conexão com a internet.")));

      return null;
    }
  } else {
    //throw Exception('Failed to load post');
    // ignore: deprecated_member_use
    scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(
            "Falha de comunicação! Verifique sua conexão com a internet.")));
    return null;
  }
}

Future<Map<String, dynamic>> promessaB(GlobalKey<ScaffoldState> scaffoldKey,
    String servico, String referencia, Object obj) async {
  //String objjson = json.encode(obj);
  /*String url =
      "${configApp.urlServidor}/${configApp.servlet}?tela=${servico}&obj=${objjson}";*/
  //String url = "${configApp.urlServidor}/${configApp.servlet}?tela=${servico}";
  String url =
      // ignore: unnecessary_brace_in_string_interps
      '${configApp.urlServidor}${configApp.servlet}?metodo=${servico}&${referencia}=${obj}';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    try {
      return json.decode(response.body);
    } catch (e) {
      //throw Exception('Formato inválido de retorno');
      // ignore: deprecated_member_use
      scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text(
              "Falha ao ler dados do servidor! Verifique sua conexão com a internet.")));

      return null;
    }
  } else {
    //throw Exception('Failed to load post');
    // ignore: deprecated_member_use
    scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(
            "Falha de comunicação! Verifique sua conexão com a internet.")));
    return null;
  }
}

String textToMd5(String text) {
  return md5.convert(utf8.encode(text)).toString();
}
