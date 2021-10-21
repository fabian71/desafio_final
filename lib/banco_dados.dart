import 'package:banco_dados/database.dart';

Future<void> main() async {
  final database = Database();
  var mysqlConnection = await database.openConnection();

  // var query = await mysqlConnection.query('insert into aluno(id, nome) values(?,?)', [
  //   null,
  //   'Fabiano 33',
  // ]);

  // print(query.affectedRows);

  // var result = await mysqlConnection.query('select * from aluno');

  // result.forEach((row) { 
  //   print(row['nome']);
  // });

  var resultUnico = await mysqlConnection.query('select * from aluno where id=?',[1]);

  resultUnico.forEach((row) { 
    print(row['nome']);
  });

}
  