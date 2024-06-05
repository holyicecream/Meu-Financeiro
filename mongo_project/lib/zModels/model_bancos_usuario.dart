// To parse this JSON data, do
//
//     final mongoDbModelBancosUsuario = mongoDbModelBancosUsuarioFromJson(jsonString);

import 'dart:convert';

import 'package:fixnum/fixnum.dart';

MongoDbModelBancosUsuario mongoDbModelBancosUsuarioFromJson(String str) =>
    MongoDbModelBancosUsuario.fromJson(json.decode(str));

String mongoDbModelBancosUsuarioToJson(MongoDbModelBancosUsuario data) =>
    json.encode(data.toJson());

class MongoDbModelBancosUsuario {
  int? codBancoUsuario;
  int? codCliente;
  int? codBanco;
  String? banco;
  String? contaCorrente;
  Int64? cpf;

  MongoDbModelBancosUsuario({
    this.codBancoUsuario,
    this.codCliente = 0,
    this.codBanco = 0,
    this.banco = '',
    this.contaCorrente = '',
    this.cpf,
  });

  factory MongoDbModelBancosUsuario.fromJson(Map<String, dynamic> json) =>
      MongoDbModelBancosUsuario(
        codBancoUsuario: json["cod_bancoUsuario"],
        codCliente: json["cod_cliente"],
        codBanco: json["cod_banco"],
        banco: json["banco"],
        contaCorrente: json["conta_corrente"],
        cpf: json["cpf"],
      );

  Map<String, dynamic> toJson() => {
        "cod_bancoUsuario": codBancoUsuario,
        "cod_cliente": codCliente,
        "cod_banco": codBanco,
        "banco": banco,
        "conta_corrente": contaCorrente,
        "cpf": cpf,
      };
}
