import 'package:banco_dados/models/estado.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class EstadoRepository {
  Future<List<Estado>> getEstados() async {
    var urlEstados =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados';

    var response = await http.get(Uri.parse(urlEstados));

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((i) => Estado.fromMap(i))
          .toList();
    } else {
      throw Exception();
    }

  }
}
