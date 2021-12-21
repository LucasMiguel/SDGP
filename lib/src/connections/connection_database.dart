import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class ConnectionDB {
  final dbName = "data.db";

  ///Contrutor Vazio
  ConnectionDB();

  ///Função para conexão com o banco de dados
  Future<Database> connect() async {
    //Testa se já existe um arquivo com o nome do banco de dados
    if (!await databaseExists(join(await getDatabasesPath(), dbName))) {
      createDB(); //Caso não tenha é chamado a função para fazer a cópia
    }
    //Faz a abertura do banco de dados
    return openDatabase(join(await getDatabasesPath(), dbName));
  }

  ///Função para a "Criação do banco de dados"
  Future<void> createDB() async {
    // Faz a copia do asset
    ByteData data = await rootBundle.load(join("db", dbName));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    if (await databaseExists(join(await getDatabasesPath(), dbName))) {
      // Write and flush the bytes written
      await io.File(join(await getDatabasesPath(), dbName))
          .writeAsBytes(bytes, flush: true);
    }
  }

  ///Função que faz a inserção dos dados
  Future<int?> insertData(var object, String table) async {
    final database = await connect();
    int idReturn;
    try {
      idReturn = await database.insert(
        table,
        object.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await database.close();
      return idReturn;
    } catch (e) {
      print(e.toString());
      await database.close();
      return 0;
    }
  }

  ///Função que irá atualizar os dados
  Future<int?> updateData(var object, String table, int id) async {
    final database = await connect();
    int idReturn;
    try {
      idReturn = await database.update(
        table,
        object.toMap(),
        where: 'id = ?',
        whereArgs: [id],
      );
      await database.close();
      return idReturn;
    } catch (e) {
      print(e.toString());
      await database.close();
      return -1;
    }
  }

  ///Função que irá retornar todos os dados da query
  Future<List<Map<String, dynamic>>> getAllData(
      {required String table, String? columnsWhere, var valueWhere}) async {
    List<Map<String, dynamic>> map;
    final database = await connect();
    if (columnsWhere == null) {
      map = await database.query(table);
      //Fechando banco de dados
      await database.close();
      return map;
    } else {
      map = await database.query(table,
          where: columnsWhere, whereArgs: valueWhere);
      //Fechando banco de dados
      await database.close();
      return map;
    }
  }

  ///Função que irá retornar o resultado da query passada
  Future<List<Map<String, dynamic>>> getExecQuery(String query) async {
    List<Map<String, dynamic>> map;
    final database = await connect();

    map = await database.rawQuery(query);
    //Fechando banco de dados
    await database.close();
    return map;
  }

  ///Função que retorna o ultimo id da tabela selecionada
  Future<int> getLastId(String table) async {
    List<Map<String, dynamic>> map;
    final database = await connect();
    try {
      map = await database
          .rawQuery("SELECT * FROM $table ORDER BY id DESC LIMIT 1;");
      print(map);
      //Fechando banco de dados
      await database.close();
      if (map.isNotEmpty) {
        return map[0]['id'];
      }
      return 0;
    } catch (e) {
      print("Erro: $e");
      //Fechando banco de dados
      await database.close();
      return 0;
    }
  }

  ///Função que irá apagar um item da tabela
  Future<bool> deleteItem(
      {required String table,
      required String whereColumn,
      required var whereValues}) async {
    final database = await connect();
    try {
      await database.delete(table, where: whereColumn, whereArgs: whereValues);
      //Fechando banco de dados
      await database.close();
      return true;
    } catch (e) {
      print(e);
      //Fechando banco de dados
      await database.close();
      return false;
    }
  }

  ///Função que irá limpar a tabela para adicionar o novo valor
  Future<bool> deleteTable(String table) async {
    final database = await connect();
    try {
      await database.delete(table);
      //Fechando banco de dados
      await database.close();
      return true;
    } catch (e) {
      print(e);
      //Fechando banco de dados
      await database.close();
      return false;
    }
  }
}
