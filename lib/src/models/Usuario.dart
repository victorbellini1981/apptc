class Usuario {
  int idusuario;
  String email;
  String senha;

  Usuario({this.idusuario, this.email, this.senha});

  Usuario.fromJson(Map<String, dynamic> json) {
    idusuario = json['idusuario'];
    email = json['email'];
    senha = json['senha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idusuario'] = this.idusuario;
    data['email'] = this.email;
    data['senha'] = this.senha;

    return data;
  }
}
