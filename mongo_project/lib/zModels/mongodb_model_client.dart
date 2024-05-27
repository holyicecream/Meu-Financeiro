import 'dart:convert';
import 'package:fixnum/fixnum.dart';
import 'package:mongo_dart/mongo_dart.dart';

MongoDbModelClient mongoDbModelFromJson(String str) =>
    MongoDbModelClient.fromJson(json.decode(str));

String mongoDbModelToJson(MongoDbModelClient data) =>
    json.encode(data.toJson());

class MongoDbModelClient {
  ObjectId id;
  String nome;
  Int64 cpf;
  String email;
  Int64 telefone;
  String endereco;

  MongoDbModelClient({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.email,
    required this.telefone,
    required this.endereco,
  });

  factory MongoDbModelClient.fromJson(Map<String, dynamic> json) =>
      MongoDbModelClient(
        id: json["_id"],
        nome: json["Nome"],
        cpf: json["CPF"],
        email: json["Email"],
        telefone: json["Telefone"],
        endereco: json["Endereco"],
      );

  Map<String, dynamic> toJson() => {
        "Object_Id": id.toJson(),
        "Nome": nome,
        "CPF": cpf,
        "Email": email,
        "Telefone": telefone,
        "Endereco": endereco,
      };
}

// class ObjectId {
//   String oid;

//   ObjectId({
//     required this.oid,
//   });

//   factory ObjectId.fromJson(Map<String, dynamic> json) => ObjectId(
//         oid: json["\u0024oid"],
//       );

//   Map<String, dynamic> toJson() => {
//         "\u0024oid": oid,
//       };
// }
