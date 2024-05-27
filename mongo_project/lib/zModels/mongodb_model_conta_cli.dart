import 'dart:convert';
import 'package:fixnum/fixnum.dart';
import 'package:mongo_dart/mongo_dart.dart';

MongoDbModelContaCli mongoDbModelContaCliFromJson(String str) =>
    MongoDbModelContaCli.fromJson(json.decode(str));

String mongoDbModelContaCliToJson(MongoDbModelContaCli data) =>
    json.encode(data.toJson());

class MongoDbModelContaCli {
  ObjectId id;
  int numeroConta;
  String tipoConta;
  String chavePix;
  double saldo;
  double limite;
  Int64 cpf;
  int numeroAgencia;

  MongoDbModelContaCli({
    required this.id,
    required this.numeroConta,
    required this.tipoConta,
    required this.chavePix,
    required this.saldo,
    required this.limite,
    required this.cpf,
    required this.numeroAgencia,
  });

  factory MongoDbModelContaCli.fromJson(Map<String, dynamic> json) =>
      MongoDbModelContaCli(
        id: json["_id"],
        numeroConta: json["Numero_Conta"],
        tipoConta: json["Tipo_Conta"],
        chavePix: json["Chave_Pix"],
        saldo: json["Saldo"],
        limite: json["Limite"],
        cpf: json["CPF"],
        numeroAgencia: json["Numero_Agencia"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "Numero_Conta": numeroConta,
        "Tipo_Conta": tipoConta,
        "Chave_Pix": chavePix,
        "Saldo": saldo,
        "Limite": limite,
        "CPF": cpf,
        "Numero_Agencia": numeroAgencia,
      };
}
