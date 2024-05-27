import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

MongoDbModelTransacoes mongoDbModelContaCliFromJson(String str) =>
    MongoDbModelTransacoes.fromJson(json.decode(str));

String mongoDbModelContaCliToJson(MongoDbModelTransacoes data) =>
    json.encode(data.toJson());

class MongoDbModelTransacoes {
  ObjectId id;
  DateTime data;
  int dia;
  int numeroConta;
  int numeroAgencia;
  double saldo;
  double limite;
  String chavePix;
  int destinatarioConta;
  int destinatarioAgencia;
  String chavePixDestinatario;
  double valor;

  MongoDbModelTransacoes({
    required this.id,
    required this.data,
    required this.dia,
    required this.numeroConta,
    required this.numeroAgencia,
    required this.saldo,
    required this.limite,
    required this.chavePix,
    required this.destinatarioConta,
    required this.destinatarioAgencia,
    required this.chavePixDestinatario,
    required this.valor
  });

  factory MongoDbModelTransacoes.fromJson(Map<String, dynamic> json) =>
      MongoDbModelTransacoes(
        id: json["_id"],
        data: json["Data"],
        dia: json["Dia"],
        numeroConta: json["Numero_Conta"],
        numeroAgencia: json["Numero_Agencia"],
        saldo: json["Saldo"],
        limite: json["Limite"],
        chavePix: json["Chave_Pix"],
        destinatarioConta: json["Destinatario_Conta"],
        destinatarioAgencia: json["Destinatario_Agencia"],
        chavePixDestinatario: json["Chave_Pix_Destinatario"],
        valor: json["Valor"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "Data": data,
        "Dia": dia,
        "Numero_Conta": numeroConta,
        "Numero_Agencia": numeroAgencia,
        "Saldo": saldo,
        "Limite": limite,
        "Chave_Pix": chavePix,
        "Destinatario_Conta": destinatarioConta,
        "Destinatario_Agencia": destinatarioAgencia,
        "Chave_Pix_Destinatario": chavePixDestinatario,
        "Valor": valor,
      };
}
