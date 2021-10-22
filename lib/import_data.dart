import 'package:banco_dados/database.dart';
import 'package:banco_dados/models/cidade.dart';
import 'package:banco_dados/models/estado.dart';
import 'package:banco_dados/repositories/cidade_repository.dart';
import 'package:banco_dados/repositories/estado_repository.dart';

main() async {

  final database = Database();
  var mysqlConnection = await database.openConnection();

  await getEstatos(mysqlConnection);

  await Future.delayed(Duration(seconds: 2));

  mysqlConnection.close();
  
}

Future<void> getEstatos(mysqlConnection) async {
  var estadosRepository = EstadoRepository();
  try {
    List<Estado> estados = await estadosRepository.getEstados();

    for (var e in estados) {
      await insertEstadoBd(e: e, mysqlConnection: mysqlConnection);
    }

    print('######## Import finalizado ########');
  } on Exception catch (e) {
    print('Erro ao buscar ou inserir estado. ERRO: $e');
  }
}

Future<void> getCidades({required ufId, required Estado estado, required mysqlConnection}) async {
  var cidadesRepository = CidadeRepository();

  try {
    List<Cidade> cidades = await cidadesRepository.getCidades(id: estado.id);
    for (var c in cidades) {
      print(c.nome);
      //await Future.delayed(Duration(seconds: 2));
      insertCidadeBd(ufId: ufId, cidade: c, mysqlConnection: mysqlConnection);
    }
  } on Exception catch (e) {
    print('Erro ao buscar cidade. ERRO: $e');
  }
}

Future insertCidadeBd({required int ufId, required Cidade cidade, required mysqlConnection}) async {
  print('Inserindo cidade: ');
  print('Nome: ${cidade.nome}');
  print('ID_if: $ufId');

  try {
    var result = await mysqlConnection
        .query('insert into cidade(id_uf, nome) values(?,?)', [
      ufId,
      cidade.nome,
    ]);

    if (result.insertId != null) {
      print('${cidade.nome} cadastrado com sucesso!');
      print('-------');
    }

  } on Exception catch (e) {
    print('Erro ao cadastrar cidade: $e');
  }
}

Future insertEstadoBd({required Estado e, mysqlConnection}) async {
  print('Inserindo estado: ');

  try {
    var result = await mysqlConnection
        .query('insert into estado(uf, nome) values(?,?)', [
      e.uf,
      e.nome,
    ]);

    if (result.insertId != null) {
      print('${e.nome} cadastrado com sucesso!');
      print('-------');

      var ufId = result.insertId;

      await getCidades(ufId: ufId, estado: e, mysqlConnection: mysqlConnection);
    } else {
      throw Exception();
    }


  } on Exception catch (e) {
    print('Erro ao cadastrar estado: $e');
  }
}
