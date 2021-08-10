class ConfigApp {
  String nomeApp = "";
  bool teste = false;
  String urlServidor = "";
  String servlet = "";
  bool testeServidor = true;

  ConfigApp(String nomeApp, String servlet, bool teste, bool testeServidor) {
    this.nomeApp = nomeApp;
    this.servlet = servlet;
    this.teste = teste;
    this.testeServidor = testeServidor;
  }
}
