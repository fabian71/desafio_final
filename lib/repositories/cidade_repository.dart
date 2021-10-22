import 'package:banco_dados/models/cidade.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CidadeRepository {

  Future<List<Cidade>> getCidades({required int id}) async {
    var urlCidades =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados/${id.toString()}/distritos';

    var response = await http.get(Uri.parse(urlCidades));

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((i) => Cidade.fromMap(i))
          .toList();
    } else {
       throw Exception();
    }
  }
}
