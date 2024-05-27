import 'package:flutter/material.dart';
import 'zDatabase/mongodb_agencia.dart';
import 'zDatabase/mongodb_banco.dart';
import 'zDatabase/mongodb_client.dart';
import 'zDatabase/mongodb_conta_cli.dart';
import 'zDatabase/mongodb_transacoes.dart';
import 'myapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MongoDatabaseAgencia.connect();
  //print('1 foi');
  MongoDatabaseBanco.connect();
  //print('2 foi');
  MongoDatabaseClient.connect();
  //print('3 foi');
  MongoDatabaseContaCli.connect();
  //print('4 foi');
  MongoDatabaseTransacoes.connect();
  //print('5 foi*');
  runApp(const MyApp()); //precisa importar myapp.dart
}
