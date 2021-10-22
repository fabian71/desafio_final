import 'dart:convert';

class Cidade {

  final String idUf;
  final String nome;
  Cidade({
    required this.idUf,
    required this.nome,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_uf': idUf,
      'nome': nome,
    };
  }

  factory Cidade.fromMap(Map<String, dynamic> map) {
    return Cidade(
      idUf: map['municipio']['microrregiao']['mesorregiao']['UF']['id']?.toString() ?? '',
      nome: map['nome'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Cidade.fromJson(String source) => Cidade.fromMap(json.decode(source));
}
