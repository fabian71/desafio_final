# Dart: Desafio Final - Fabiano 

O desafio se resume a popular duas tabelas do banco de dados com estados e cidades do Brasil.

## Configuração

Crie suas tabelas de banco de dados;

```mysql
CREATE TABLE estado (
  id int not null primary key auto_increment,
  uf varchar(2),
  nome varchar(255)
);


CREATE TABLE cidade (
  id int not null primary key auto_increment,
  id_uf int,
  nome varchar(255),
   FOREIGN KEY (id_uf)
      REFERENCES estado(id)
);​
```

Edite o arquivo lib/database.dart e insira suas configurações de conexão com o Mysql


## Uso

Execute o arquivo lib/import_data.dart 
