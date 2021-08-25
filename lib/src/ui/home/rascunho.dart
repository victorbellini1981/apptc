/*

else {
          Map<String, dynamic> retorno1 =
              await promessa(_scaffoldKey, "PostUsuarioP", obj);
          if (retorno1["situacao"] == "sucesso" &&
              retorno1['obj']['idusuario'] != 0) {
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

*/