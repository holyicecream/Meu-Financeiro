import 'dart:convert';
import 'package:fixnum/fixnum.dart';
import 'package:mongo_dart/mongo_dart.dart';

MongoDbModelBanco mongoDbModelBancoFromJson(String str) =>
    MongoDbModelBanco.fromJson(json.decode(str));

String mongoDbModelBancoToJson(MongoDbModelBanco data) =>
    json.encode(data.toJson());

class MongoDbModelBanco {
  ObjectId id;
  String nome;
  Int64 cnpj;
  Int64 telefone;
  String grupo;
  String endereco;
  String email;

  MongoDbModelBanco({
    required this.id,
    required this.nome,
    required this.cnpj,
    required this.telefone,
    required this.grupo,
    required this.endereco,
    required this.email,
  });

  factory MongoDbModelBanco.fromJson(Map<String, dynamic> json) =>
      MongoDbModelBanco(
        id: json["_id"],
        nome: json["Nome"],
        cnpj: json["CNPJ"],
        telefone: json["Telefone"],
        grupo: json["Grupo"],
        endereco: json["Endereco"],
        email: json["Email"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "Nome": nome,
        "CNPJ": cnpj,
        "Telefone": telefone,
        "Grupo": grupo,
        "Endereco": endereco,
        "Email": email,
      };
}
