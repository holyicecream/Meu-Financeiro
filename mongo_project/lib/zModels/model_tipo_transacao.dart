import 'dart:convert';

MongoDbModelTipoTransacao mongoDbModelBancosTransacaoFromJson(String str) =>
    MongoDbModelTipoTransacao.fromJson(json.decode(str));

String mongoDbModelBancosTransacaoToJson(MongoDbModelTipoTransacao data) =>
    json.encode(data.toJson());

class MongoDbModelTipoTransacao {
  int? codTransacao;
  String? tipo;

  MongoDbModelTipoTransacao({
    this.codTransacao,
    this.tipo = '',
  });

  factory MongoDbModelTipoTransacao.fromJson(Map<String, dynamic> json) =>
      MongoDbModelTipoTransacao(
        codTransacao: json["cod_transacao"],
        tipo: json["tipo"],
      );

  Map<String, dynamic> toJson() => {
        "cod_transacao": codTransacao,
        "tipo": tipo,
      };
}
