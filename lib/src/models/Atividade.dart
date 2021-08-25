class Atividade {
  int idatividade;
  // ignore: non_constant_identifier_names
  String data_atv;
  String atividade;

  // ignore: non_constant_identifier_names
  Atividade({this.idatividade, this.data_atv, this.atividade});

  Atividade.fromJson(Map<String, dynamic> json) {
    idatividade = json['idatividade'];
    data_atv = json['data_atv'];
    atividade = json['atividade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idatividade'] = this.idatividade;
    data['data_atv'] = this.data_atv;
    data['atividade'] = this.atividade;

    return data;
  }
}
