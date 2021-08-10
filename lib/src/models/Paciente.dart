class Paciente {
  late int idpaciente;
  late int idusuario;
  late String nome;
  late String email;
  late String cpf;
  late String telefone;
  late String cep;
  late String uf;
  late String logradouro;
  late String numero;
  late String complemento;
  late String bairro;
  late String cidade;

  Paciente({
    required this.idpaciente,
    required this.idusuario,
    required this.nome,
    required this.email,
    required this.cpf,
    required this.telefone,
    required this.cep,
    required this.uf,
    required this.logradouro,
    required this.numero,
    required this.complemento,
    required this.bairro,
    required this.cidade,
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
