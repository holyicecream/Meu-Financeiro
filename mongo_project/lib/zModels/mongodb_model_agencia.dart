import 'dart:convert';
import 'package:fixnum/fixnum.dart';
import 'package:mongo_dart/mongo_dart.dart';

MongoDbModelAgencia mongoDbModelAgenciaFromJson(String str) =>
    MongoDbModelAgencia.fromJson(json.decode(str));

String mongoDbModelAgenciaToJson(MongoDbModelAgencia data) =>
    json.encode(data.toJson());

class MongoDbModelAgencia {
  ObjectId id;
  String nome;
  int numeroAgencia;
  Int64 telefone;
  String endereco;
  String email;
  Int64 cnpj;

  MongoDbModelAgencia({
    required this.id,
    required this.nome,
    required this.numeroAgencia,
    required this.telefone,
    required this.endereco,
    required this.email,
    required this.cnpj,
  });

  factory MongoDbModelAgencia.fromJson(Map<String, dynamic> json) =>
      MongoDbModelAgencia(
        id: json["_id"],
        nome: json["Nome"],
        numeroAgencia: json["Numero_Agencia"],
        telefone: json["Telefone"],
        endereco: json["Endereco"],
        email: json["Email"],
        cnpj: json["CNPJ"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "Nome": nome,
        "Numero_Agencia": numeroAgencia,
        "Telefone": telefone,
        "Endereco": endereco,
        "Email": email,
        "CNPJ": cnpj,
      };
}
