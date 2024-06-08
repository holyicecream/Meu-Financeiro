import 'dart:convert';

MongoDbModelClientes clientesFromJson(String str) =>
    MongoDbModelClientes.fromJson(json.decode(str));

String clientesToJson(MongoDbModelClientes data) => json.encode(data.toJson());

class MongoDbModelClientes {
  int? codCliente;
  String? email;
  String? senha;
  String? nomeCliente;
  // Int64? cpf;
  // Int64? cnpj;

  MongoDbModelClientes({
    this.codCliente,
    this.email = '',
    this.senha = '',
    this.nomeCliente = '',
    // this.cpf,
    // this.cnpj,
  });

  factory MongoDbModelClientes.fromJson(Map<String, dynamic> json) =>
      MongoDbModelClientes(
        codCliente: json["cod_cliente"],
        email: json["email"],
        senha: json["senha"],
        nomeCliente: json["nome_cliente"],
        // cpf: json["cpf"],
        // cnpj: json["cnpj"],
      );

  Map<String, dynamic> toJson() => {
        "cod_cliente": codCliente,
        "email": email,
        "senha": senha,
        "nome_cliente": nomeCliente,
        // "cpf": cpf,
        // "cnpj": cnpj,
      };
}
