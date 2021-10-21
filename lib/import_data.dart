import 'dart:convert';
import 'package:banco_dados/models/estado.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  var urlEstados =
      'https://servicodados.ibge.gov.br/api/v1/localidades/estados';

  var response = await http.get(Uri.parse(urlEstados));

  if (response.statusCode == 200) {
    var estados = (json.decode(response.body) as List).map((i) {
      print(i);
      Estado.fromMap(i);
    }).toList();

    //print(estados);
  }
}
