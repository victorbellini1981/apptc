class Usuario {
  late int idusuario;
  late String email;
  late String senha;

  Usuario({required this.idusuario, required this.email, required this.senha});

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
