class Paciente {
  int idpaciente;
  int idusuario;
  String nome;
  String email;
  String cpf;
  String telefone;
  String cep;
  String uf;
  String logradouro;
  String numero;
  String complemento;
  String bairro;
  String cidade;

  Paciente({
    this.idpaciente,
    this.idusuario,
    this.nome,
    this.email,
    this.cpf,
    this.telefone,
    this.cep,
    this.uf,
    this.logradouro,
    this.numero,
    this.complemento,
    this.bairro,
    this.cidade,
  });

  Paciente.fromJson(Map<String, dynamic> json) {
    idpaciente = json['idpaciente'];
    idusuario = json['idusuario'];
    nome = json['nome'];
    email = json['email'];
    cpf = json['cpf'];
    telefone = json['telefone'];
    cep = json['cep'];
    uf = json['uf'];
    logradouro = json['logradouro'];
    numero = json['numero'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    cidade = json['cidade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idpaciente'] = this.idpaciente;
    data['idusuario'] = this.idusuario;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['cpf'] = this.cpf;
    data['telefone'] = this.telefone;
    data['cep'] = this.cep;
    data['uf'] = this.uf;
    data['logradouro'] = this.logradouro;
    data['numero'] = this.numero;
    data['complemento'] = this.complemento;
    data['bairro'] = this.bairro;
    data['cidade'] = this.cidade;

    return data;
  }
}
