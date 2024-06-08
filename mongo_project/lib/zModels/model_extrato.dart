import 'dart:convert';

MongoDbModelExtrato mongoDbModelBancosExtratoFromJson(String str) =>
    MongoDbModelExtrato.fromJson(json.decode(str));

String mongoDbModelBancosExtratoToJson(MongoDbModelExtrato data) =>
    json.encode(data.toJson());

class MongoDbModelExtrato {
  int? registro;
  int? codCliente;
  DateTime data = DateTime.now();
  double? valor;
  String? debitoCredito;
  int? codTransacao;
  String? descricaoTransacao;
  String? nomeDestinatario;
  int? codBanco;
  int? codAreaConsumo;

  MongoDbModelExtrato({
    this.registro,
    this.codCliente = 0,
    data,
    this.valor = 0,
    this.debitoCredito = '',
    this.codTransacao = 0,
    this.descricaoTransacao = '',
    this.nomeDestinatario = '',
    this.codBanco = 0,
    this.codAreaConsumo = 0,
  });

  factory MongoDbModelExtrato.fromJson(Map<String, dynamic> json) =>
      MongoDbModelExtrato(
        registro: json["registro"],
        codCliente: json["cod_cliente"],
        data: json["data"],
        valor: json["valor"],
        debitoCredito: json["debito_credito"],
        codTransacao: json["cod_transacao"],
        descricaoTransacao: json["descricao_transacao"],
        nomeDestinatario: json["nome_destinatario"],
        codBanco: json["cod_banco"],
        codAreaConsumo: json["cod_area_consumo"],
      );

  Map<String, dynamic> toJson() => {
        "registro": registro,
        "cod_cliente": codCliente,
        "data": data.toIso8601String(),
        "valor": valor,
        "debito_credito": debitoCredito,
        "cod_transacao": codTransacao,
        "descricao_transacao": descricaoTransacao,
        "nome_destinatario": nomeDestinatario,
        "cod_banco": codBanco,
        "cod_area_consumo": codAreaConsumo,
      };
}
