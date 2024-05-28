// To parse this JSON data, do
//
//     final mongoDbModelBancos = mongoDbModelBancosFromJson(jsonString);

import 'dart:convert';

MongoDbModelBancos mongoDbModelBancosFromJson(String str) =>
    MongoDbModelBancos.fromJson(json.decode(str));

String mongoDbModelBancosToJson(MongoDbModelBancos data) =>
    json.encode(data.toJson());

class MongoDbModelBancos {
  int? codBanco;
  String? banco;

  MongoDbModelBancos({
    this.codBanco,
    this.banco = '',
  });

  factory MongoDbModelBancos.fromJson(Map<String, dynamic> json) =>
      MongoDbModelBancos(
        codBanco: json["cod_banco"],
        banco: json["banco"],
      );

  Map<String, dynamic> toJson() => {
        "cod_banco": codBanco,
        "banco": banco,
      };
}
